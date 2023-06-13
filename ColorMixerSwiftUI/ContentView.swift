//
//  ContentView.swift
//  ColorMixerSwiftUI
//
//  Created by Alex on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        VStack {
            ColorView(
                red: redSliderValue,
                green: greenSliderValue,
                blue: blueSliderValue
            )
            Spacer()
            VStack {
                SliderView(value: $redSliderValue, color: .red)
                SliderView(value: $greenSliderValue, color: .green)
                SliderView(value: $blueSliderValue, color: .blue)
            }
            Spacer()
        }
        .padding()
    }
}

// MARK: - ColorView
struct ColorView: View {
    let red: Double
    let green: Double
    let blue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .foregroundColor(Color(red: red/255, green: green/255, blue: blue/255))
            .frame(width: 340 ,height: 280)
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
