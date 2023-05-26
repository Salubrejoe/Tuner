//
//  ContentView.swift
//  TunerTest
//
//  Created by Lore P on 20/04/2023.
//

import SwiftUI
import Pitchy
import Beethoven

struct MainView: View {
  @StateObject var controller = PitchData()
  var pitchEngine = PitchEngine()
//  {
//    let config = Config(
//      bufferSize: 128,
//      estimationStrategy: .yin
//    )
//    return PitchEngine(config: config)
//  }
  
  var body: some View {
    VStack {
        VStack {
          
          // LETTER
//          Spacer()
          VStack {
            if isPlaying() {
              Text(controller.pitchString)
                .font(.system(size: 100))
            } else {
              Text("Ready")
                .font(.system(size: 50))
              Text("to listen")
                .font(.system(size: 50))
            }
          }
          .frame(maxWidth: .infinity)
          .frame(maxHeight: 300)
          
          
          
          // WAVES
          ZStack {
            if isPlaying() {
              WaveFormView(amplitude: 30,
                           frequency: controller.pitchFrequency,
                           waveColor: controller.isTuned ? .green : .red,
                           echoes: controller.offsetCents)
              WaveFormView(amplitude: 30,
                           frequency: controller.closestOffsetFrequency,
                           waveColor: .primary,
                           echoes: 1)
            } else {
              WaveFormView(amplitude: 30,
                           frequency: 440,
                           waveColor: .secondary,
                           echoes: 30)
            }
            
          }//: Waves
          .frame(maxWidth: .infinity)
          .frame(maxHeight: 400)
        }
      
      
    }//: MainView Container
    .onAppear {
      pitchEngine.delegate = controller
      pitchEngine.levelThreshold = -30.0
      DispatchQueue.main.async { pitchEngine.start() }
    }
  }
  
  func isPlaying() -> Bool {
    pitchEngine.signalLevel > -27
  }
}




