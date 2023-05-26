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
      Spacer()
      drawString
      Spacer()
      drawWaves()
      
    }//: MainView Container
    .animation(.default, value: isPlaying())
    .onAppear {
      pitchEngine.delegate = controller
      pitchEngine.levelThreshold = -30.0
      DispatchQueue.main.async { pitchEngine.start() }
    }
    
  }
  
  func isPlaying() -> Bool {
    pitchEngine.signalLevel > -30
  }
  
  @ViewBuilder
  private var drawString: some View {
    Text(isPlaying() ? controller.pitchString : "Ready to listen")
      .font(.system(size: isPlaying() ? 100 : 20))
      .padding(.top)
      .frame(height: 100)
  }
  
  @ViewBuilder
  func drawWaves() -> some View {
    ZStack {
      if isPlaying() {
        WaveFormView(amplitude: 30,
                     frequency: controller.pitchFrequency,
                     waveColor: controller.isTuned ? .blue : .red,
                     echoes: controller.offsetCents)
        WaveFormView(amplitude: 30,
                     frequency: controller.closestOffsetFrequency,
                     waveColor: controller.isTuned ? .blue : .red,
                     echoes: 1)
      } else {
        WaveFormView(amplitude: 5,
                     frequency: 110,
                     waveColor: .secondary,
                     echoes: 1)
        WaveFormView(amplitude: 5,
                     frequency: 170,
                     waveColor: .secondary,
                     echoes: 1)
      }
    }
    .opacity(isPlaying() ? 1 : 0.2)
    .frame(maxHeight: 400)
  }
}






