//
//  ProgressBar.swift
//  Time Timer
//
//  Created by Yoan on 04/04/2023.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var selectedColor: Color
    @Binding var progressValue: CGFloat
    
    var body: some View {
        // Progress bar background
        Circle()
            .stroke(lineWidth: 20)
            .opacity(0.3)
            .foregroundColor(.gray)
        
        // Progress bar
            Circle()
            .trim(from: 0.0, to: progressValue)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(selectedColor)
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 1))
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(selectedColor: .constant(.red), progressValue: .constant(3600))
    }
}
