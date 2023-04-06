//
//  TimeManager.swift
//  Time Timer
//
//  Created by Yoan on 31/03/2023.
//

import Foundation
import AVFoundation

class TimerManager: ObservableObject {
    @Published var progress: CGFloat = 1.0
    @Published var isTimerRunning = false
    var audioPlayer: AVAudioPlayer?
    @Published var playIsPressed = false
    
    private var timer: Timer? = nil
    var timing: [Int] {
        var data : [Int] = []
        for i in 0...60 {
            data.append(i)
        }
        return data
    }

    func startTimer(during: CGFloat) {
        if isTimerRunning {
            if playIsPressed {
                timer?.invalidate()
                playIsPressed = false
            } else {
                launchTimer(during: during)
                playIsPressed = true
            }
        } else {
            self.progress = 1
            launchTimer(during: during)
        }
    }
    
    func launchTimer(during: CGFloat) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if self.progress > 0.0 {
                self.isTimerRunning = true
                self.playIsPressed = true
                self.progress -= 0.2 / during
            } else {
                self.playSound()
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        isTimerRunning = false
        playIsPressed = false
        timer?.invalidate()
        progress = 0
    }
    
    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "UrgentSimpleTone", withExtension: "wav") else { return }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Une erreur s'est produite lors de la lecture du son: \(error.localizedDescription)")
            }
    }
    
}
