//
//  SliderView.swift
//  ColorMixerSwiftUI
//
//  Created by Alex on 13.06.2023.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    @State private var textValue = ""
    let color: Color
    
    var body: some View {
        HStack {
            TextView(value: $value, color: color)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: value) { newValue in
                    textValue = "\(lround(newValue))"
                }
                .animation(.easeIn, value: value)
            TextFieldView(value: $value, text: $textValue)
        }
    }
}

// MARK: - TextFieldView
struct TextFieldView: View {
    @Binding var value: Double
    @Binding var text: String
    @State private var isPresented = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(.roundedBorder)
            .frame(width: 50)
            .keyboardType(.decimalPad)
            .focused($isFocused)
            .alert("Out of Range", isPresented: $isPresented, actions: {}) {
                Text("Use a range of numbers from 0 to 255")
            }
            .toolbar {
                if isFocused {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            validateValues()
                            isFocused = false
                        }
                    }
                }
            }
    }
    
    private func validateValues() {
        if let validValue = Double(text), (0...255).contains(validValue) {
            value = validValue
        } else {
            isPresented.toggle()
            text = ""
        }
    }
}

// MARK: - TextView
struct TextView: View {
    @Binding var value: Double
    let color: Color
    
    var body: some View {
        Text("\(lround(value))")
            .fontWeight(.semibold)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .frame(width: 40)
    }
}
