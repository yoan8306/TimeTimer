//
//  ColorPalette.swift
//  Time Timer
//
//  Created by Yoan on 04/04/2023.
//

import SwiftUI

struct ColorPalette: View {
    let colors: [Color] = [.pink, .red, .blue, .green, .purple, .teal]
    @Binding var selectedColor: Color

    var body: some View {
        
        VStack {
            
            ColorPicker("Pick a color", selection: $selectedColor)
                .frame(maxWidth: 150, maxHeight: 100)
                .presentationDetents([.medium, .large])
            HStack {
                ForEach(colors, id: \.self) { color in
                    color
                        .frame(width: 30, height: 30)
                        .cornerRadius(15)
                        .onTapGesture {
                            self.selectedColor = color
                        }
                }
            }
            withAnimation {
                Circle().foregroundColor(selectedColor).frame(width: 100, height: 100)
                    .animation(.easeIn(duration: 1))
                
            }
        }
    }
}

struct ColorPalette_Previews: PreviewProvider {
    static var previews: some View {
        ColorPalette(selectedColor: .constant(.blue))
    }
}
