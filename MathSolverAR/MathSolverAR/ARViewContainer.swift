import SwiftUI
import ARKit
import RealityKit
import Vision

struct ARViewContainer: UIViewRepresentable {
    let sceneView = ARView(frame: .zero)

    func makeUIView(context: Context) -> ARView {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(config)
        
        return sceneView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Handle any updates to the ARView here
    }
    
    func findTransform(for observation: VNRecognizedTextObservation) -> simd_float4x4? {
        let boundingBox = observation.boundingBox
        let screenSize = UIScreen.main.bounds.size
        
        let midX = boundingBox.midX * Float(screenSize.width)
        let midY = (1 - boundingBox.midY) * Float(screenSize.height)

        let hitResults = sceneView.hitTest(CGPoint(x: CGFloat(midX), y: CGFloat(midY)), types: [.featurePoint])

        if let closestResult = hitResults.first {
            return closestResult.worldTransform
        }
        
        return nil
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
