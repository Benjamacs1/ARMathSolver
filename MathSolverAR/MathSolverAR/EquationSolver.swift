//
//  EquationSolver.swift
//  MathSolverAR
//
//  Created by Benjamin  on 2024-09-27.
//


import Foundation

class EquationSolver {
    func solveEquation(_ equation: String) -> String? {
        // Remove whitespace
        let trimmedEquation = equation.replacingOccurrences(of: " ", with: "")
        
        // Split equation into left and right parts
        let components = trimmedEquation.components(separatedBy: "=")
        guard components.count == 2 else { return nil }
        
        let left = components[0]
        let right = components[1]
        
        // Example: Solve for x in "x+2=5"
        // This is a simplified solver and may not handle all cases
        let variable = "x"
        let pattern = "(\(variable))(\\+|\\-)(\\d+)"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }
        let range = NSRange(location: 0, length: left.utf16.count)
        guard let match = regex.firstMatch(in: left, options: [], range: range) else { return nil }
        
        guard match.numberOfRanges == 4 else { return nil }
        
        // Extract operator and operand
        if let opRange = Range(match.range(at: 2), in: left),
           let operandRange = Range(match.range(at: 3), in: left) {
            let operatorSymbol = String(left[opRange])
            let operandString = String(left[operandRange])
            guard let operand = Double(operandString),
                  let rightValue = Double(right) else { return nil }
            
            var solution: Double = 0
            switch operatorSymbol {
            case "+":
                solution = rightValue - operand
            case "-":
                solution = rightValue + operand
            default:
                return nil
            }
            
            return "\(variable) = \(solution)"
        }
        
        return nil
    }
}
