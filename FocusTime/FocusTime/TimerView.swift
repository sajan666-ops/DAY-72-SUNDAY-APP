//
//  TimerView.swift
//  FocusTime
//
//  Created by SAJAN  on 14/09/25.
//

import SwiftUI
import Combine

struct TimerView: View {
    @State private var isRunning = false
    @State private var timeRemaining = 25 * 60 // 25 mins
    @State private var timerCancellable: Cancellable?
    
    private let focusTime = 25 * 60
    private let breakTime = 5 * 60
    
    var body: some View {
        VStack(spacing: 40) {
            
            // Progress Circle
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.2)
                    .foregroundColor(.blue)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(timeProgress()))
                    .stroke(
                        AngularGradient(gradient: Gradient(colors: [.blue, .purple]),
                                        center: .center),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: timeRemaining)
                
                // Time label
                Text(formatTime(timeRemaining))
                    .font(.system(size: 40, weight: .bold, design: .rounded))
            }
            .frame(width: 250, height: 250)
            
            // Controls
            HStack(spacing: 30) {
                Button(action: startTimer) {
                    Label("Start", systemImage: "play.fill")
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(12)
                }
                
                Button(action: pauseTimer) {
                    Label("Pause", systemImage: "pause.fill")
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(12)
                }
                
                Button(action: resetTimer) {
                    Label("Reset", systemImage: "arrow.counterclockwise")
                        .padding()
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(12)
                }
            }
        }
        .padding()
    }
    
    // MARK: - Timer Functions
    private func startTimer() {
        guard !isRunning else { return }
        isRunning = true
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    // Switch to break or reset
                    resetTimer()
                }
            }
    }
    
    private func pauseTimer() {
        isRunning = false
        timerCancellable?.cancel()
    }
    
    private func resetTimer() {
        pauseTimer()
        timeRemaining = focusTime
    }
    
    // MARK: - Helpers
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    private func timeProgress() -> Double {
        return Double(timeRemaining) / Double(focusTime)
    }
}


#Preview {
    TimerView()
}
