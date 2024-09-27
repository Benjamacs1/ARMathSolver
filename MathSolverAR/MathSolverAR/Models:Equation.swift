//
//  Equation.swift
//  MathSolverAR
//
//  Created by Benjamin  on 2024-09-27.
//


import Foundation

struct Equation: Identifiable {
    let id = UUID()
    let expression: String
    let solution: String
}
