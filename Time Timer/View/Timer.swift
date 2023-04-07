//
//  Timer.swift
//  Time Timer
//
//  Created by Yoan on 31/03/2023.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var timerManager = TimerManager()
    @State private var timeSelected = 1
    @State var selectedColor: Color = Color.red
    @State var isPresented = false
    var during: CGFloat = 0
    
    var body: some View {
        
        ZStack{
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 35,height: 35)
            }
            .padding()
            
            .position(x: UIScreen.main.bounds.maxX - 80, y: UIScreen.main.bounds.minY + 30)
            
            VStack(spacing: 20) {
                Group {
                    ZStack {
                        ProgressBar(selectedColor: $selectedColor, progressValue: $timerManager.progress)
                        
                        VStack {
                            Group {
                                withAnimation {
                                    HStack {
                                        Text(formatTimeRemaining())
                                            .font(.title)
                                            .foregroundColor((timerManager.progress * CGFloat(timeSelected) < 1) ? .red : Color.primary)
                                    }
                                }
                                Text("remaining")
                                    .font(.title3)
                            }
                        }
                    }
                    .padding()
                }
                
                HStack(spacing: 80) {
                    Button(action: {
                        if timerManager.isTimerRunning {
                            timerManager.stopTimer()
                        }
                        
                    }) { Image(systemName: "stop.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    
                    Button {
                        timerManager.startTimer(during: CGFloat(timeSelected * 60))
                        
                    } label: {
                        Image(systemName: (timerManager.playIsPressed) ? "pause.circle" : "play.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor((timerManager.playIsPressed) ? Color.red : Color.green)
                    }
                }
                
                Picker(selection: $timeSelected) {
                    ForEach (0..<timerManager.timing.count, id: \.self) {
                        Text(String(timerManager.timing[$0]) + " min")
                    }
                } label: { }
            }
        }
        .sheet(isPresented: $isPresented) {
            ColorPalette(selectedColor: $selectedColor)
                .presentationDetents([
                    .medium])
        }
        .padding(.horizontal, 25.0)
    }
    
    func formatTimeRemaining() -> String {
        let minutesRemaining = Int(timerManager.progress * CGFloat(timeSelected))
        let secondsElapsed = Int(((timerManager.progress * CGFloat(timeSelected))*60).truncatingRemainder(dividingBy: 60.0))
        let formatSeconds = secondsElapsed < 10 ? String(format: "0%d", secondsElapsed) : String(secondsElapsed)
        return "\(minutesRemaining):\(formatSeconds)"
    }
    
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
