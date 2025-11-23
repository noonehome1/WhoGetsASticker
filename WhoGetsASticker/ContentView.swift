//
//  ContentView.swift
//  WhoGetsASticker
//
//  Created by Paul Wagstaff on 2025-11-22.
//

import SwiftUI

struct ContentView: View {
    @State private var winningMessage: String = ""
    @State private var posters: [String] = []
    @State private var name: String = ""
    
    @FocusState private var textFieldIsFocused: Bool
        
    var body: some View {
        VStack {
            Text("Who gets a sticker?")
                .font(.largeTitle)
                .fontWeight(.black)
            HStack {
                Button("Clear", action: {
                    posters.removeAll()
                    name = ""
                    winningMessage = ""
                    textFieldIsFocused = false
                })
                .tint(.red.opacity(0.80))
                
                Spacer()
                
                Button("Pick a Winner", action: {
                    winningMessage = "This Weeks Winner is: \n\(posters.randomElement() ?? "No Winners Yet")"
                })
                .tint(.green.opacity(0.80))
            }
            .buttonStyle(.borderedProminent)
            .font(.title2.bold())
            .disabled(posters.isEmpty)

            
            Image("sticker")
                .resizable()
                .scaledToFit()
            
            Text(winningMessage)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
//                .frame(height: 160)
            
            Spacer()
            
            Text("This Weeks Posters Are:")
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
            
            Text(posters.isEmpty ? "No Posters This Week" : posters.joined(separator: ", "))
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
            
            HStack {
                TextField("Enter Poster Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1.0)
                    )
                    .autocorrectionDisabled()
                    .focused($textFieldIsFocused)
                    .onSubmit {
                        posters.append(contentsOf: name.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces).isEmpty ? nil : String($0.trimmingCharacters(in: .whitespaces)) }.compactMap { $0 })
                        name = ""
                        textFieldIsFocused = false
                    }
                
                Button {
                    posters.append(name)
                    name = ""
                    textFieldIsFocused = false
                } label: {
                    Image(systemName: "plus")
                }
                .bold()
            }
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
