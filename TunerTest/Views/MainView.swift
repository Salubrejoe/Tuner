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
          Spacer()
          Text(controller.pitchString)
            .font(.system(size: 100))
          
          // WAVES
          ZStack {
              WaveFormView(amplitude: 30,
                           frequency: controller.pitchFrequency,
                           waveColor: controller.isTuned ? .green : .primary,
                           echoes: 5)
              WaveFormView(amplitude: 30,
                           frequency: controller.closestOffsetFrequency,
                           waveColor: controller.isTuned ? .green : .red,
                           echoes: 1)
              .offset(y: controller.offsetCents)
            
          }//: Waves
          
          Spacer()
        }
      
      
    }//: MainView Container
    .onAppear {
      pitchEngine.delegate = controller
      pitchEngine.levelThreshold = -30.0
      DispatchQueue.main.async { pitchEngine.start() }
    }
  }
}




