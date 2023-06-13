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
            Text("\(lround(value))")
                .fontWeight(.semibold)
                .foregroundColor(color)
                .multilineTextAlignment(.leading)
                .frame(width: 40)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: value) { newValue in
                    textValue = String(format: "%.0f", newValue)
                }
                .animation(.easeIn, value: value)
            TextField("", text: $textValue)
                .onSubmit {
                    if let validValue = Double(textValue) {
                        value = validValue
                    }
                }
                .textFieldStyle(.roundedBorder)
                .frame(width: 50)
                .keyboardType(.decimalPad)
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: .constant(250), color: .blue)
    }
}
