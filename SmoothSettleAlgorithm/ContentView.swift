//
//  ContentView.swift
//  SmoothSettleAlgorithm
//
//  Created by 刘逸飞 on 2024/10/6.
//

import SwiftUI

struct ContentView: View {
    // State to hold the result from the algorithm
    @State private var result: String = "No result yet"
    
    var body: some View {
        VStack {
            Text(result)
                .padding()
            
            Button(action: {
                // Call the SimplifyDebts algorithm
                let simplifyDebts = SimplifyDebts()
                result = simplifyDebts.createGraphForDebts()
            }) {
                Text("Run Algorithm")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
