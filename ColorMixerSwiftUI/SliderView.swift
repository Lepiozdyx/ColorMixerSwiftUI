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
    @State private var isPresented = false
    
    let color: Color
    
    var body: some View {
        HStack {
            TextView(value: value, color: color)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: value) { newValue in
                    textValue = newValue.formatted()
                }
                .animation(.easeIn, value: value)
            TextFieldView(text: $textValue, action: validateValue)
                .alert("Out of Range", isPresented: $isPresented, actions: {}) {
                    Text("Use a range of numbers from 0 to 255")
                }
        }
        .onAppear {
            textValue = value.formatted()
        }
    }
    
    private func validateValue() {
        if let validValue = Double(textValue), (0...255).contains(validValue) {
            value = validValue
        } else {
            isPresented.toggle()
            textValue = ""
        }
    }
}

// MARK: - TextFieldView
struct TextFieldView: View {
    @Binding var text: String
    
    let action: () -> Void
    
    var body: some View {
        TextField("", text: $text) { _ in
            withAnimation {
                action()
            }
        }
            .textFieldStyle(.roundedBorder)
            .frame(width: 50)
            .keyboardType(.numberPad)
    }
}

// MARK: - TextView
struct TextView: View {
    let value: Double
    let color: Color
    
    var body: some View {
        Text(value.formatted())
            .fontWeight(.semibold)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .frame(width: 40)
    }
}
