import ARKit
import Vision

class Coordinator: NSObject, ARSCNViewDelegate {
    var parent: ARViewContainer
    var isProcessing = false

    init(_ parent: ARViewContainer) {
        self.parent = parent
        super.init()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let sceneView = renderer as? ARSCNView else { return }

        guard let pixelBuffer = sceneView.session.currentFrame?.capturedImage, !isProcessing else { return }
        
        isProcessing = true
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self else { return }
            defer { self.isProcessing = false }
            
            if let error = error {
                print("Text recognition error: \(error.localizedDescription)")
                return
            }
            self.handleDetectedText(request: request)
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en_US"]
        request.usesLanguageCorrection = true
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform text recognition: \(error.localizedDescription)")
                self.isProcessing = false
            }
        }
    }
    
    func handleDetectedText(request: VNRequest) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        for observation in observations {
            guard let topCandidate = observation.topCandidates(1).first else { continue }
            print("Detected text: \(topCandidate.string)")
        }
    }
}
