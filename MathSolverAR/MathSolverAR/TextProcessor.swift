//
//  TextProcessor.swift
//  MathSolverAR
//
//  Created by Benjamin  on 2024-09-27.
//


import Foundation

class TextProcessor {
    func processDetectedText(_ text: String) -> (equations: [String], instructions: [String]) {
        let equations = extractEquations(from: text)
        let instructions = extractInstructions(from: text)
        return (equations, instructions)
    }
    
    private func extractEquations(from text: String) -> [String] {
        // Simple regex to identify equations (e.g., "x + 2 = 5")
        let pattern = "[a-zA-Z]?\\s*[\\+\\-\\*/]?\\s*=?\\s*\\d+[\\d\\s\\+\\-\\*/^()xX]*"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        
        let nsText = text as NSString
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: nsText.length))
        
        let equations = matches.map { nsText.substring(with: $0.range).trimmingCharacters(in: .whitespaces) }
        return equations
    }
    
    private func extractInstructions(from text: String) -> [String] {
        // Placeholder for instruction extraction logic
        // For example, look for keywords like "solve for", "find the derivative", etc.
        // This can be enhanced using NLP techniques or keyword matching
        
        let instructionKeywords = ["solve for", "find", "calculate", "compute", "derive", "differentiate"]
        let lines = text.components(separatedBy: "\n")
        var instructions: [String] = []
        
        for line in lines {
            for keyword in instructionKeywords {
                if line.lowercased().contains(keyword) {
                    instructions.append(line)
                    break
                }
            }
        }
        
        return instructions
    }
}
