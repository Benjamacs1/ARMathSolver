//
//  SolutionView.swift
//  MathSolverAR
//
//  Created by Benjamin  on 2024-09-27.
//


import SwiftUI

struct SolutionView: View {
    var equation: String
    var solution: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Equation:")
                .font(.headline)
            Text(equation)
                .font(.body)
            Text("Solution:")
                .font(.headline)
                .padding(.top, 5)
            Text(solution)
                .font(.body)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
