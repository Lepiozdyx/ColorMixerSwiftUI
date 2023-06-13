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
    
    
    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(.roundedBorder)
            .frame(width: 50)
            .keyboardType(.decimalPad)
            .onSubmit {
                if let validValue = Double(text), (0...255).contains(validValue) {
                    value = validValue
                    return
                }
                isPresented.toggle()
                text = ""
            }
            .alert("Out of Range", isPresented: $isPresented, actions: {}) {
                Text("Use a range of numbers from 0 to 255")
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
