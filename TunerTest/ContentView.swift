//
//  ContentView.swift
//  TunerTest
//
//  Created by Lore P on 20/04/2023.
//

import SwiftUI
import Pitchy
import Beethoven

struct ContentView: View {
  var pitchEngine = PitchEngine()
  @StateObject var pitchManager = PitchManager()
  
  var body: some View {
    ZStack {
      Color(uiColor: pitchManager.offsetCents > -5.0 && pitchManager.offsetCents < 5.0 ? .systemGreen : .systemRed)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
      
      VStack {
        ZStack {
          Gauge(value: pitchManager.offsetCents, in: -100...100) {
            Text("")
          }
          
          .gaugeStyle(.accessoryCircular)
          .scaleEffect(5)
          
          
          Text(pitchManager.pitchString)
            .font(.system(size: 90, weight: .heavy))
            .fontDesign(.rounded)
            .onAppear {
              pitchEngine.delegate = pitchManager
              pitchEngine.levelThreshold = -30.0
              DispatchQueue.main.async {
                pitchEngine.start()
              }
          }
        }
        Text(String(format: "%.0f", pitchManager.offsetCents))
          .font(.headline)
          .fontWeight(.bold)
        
        
      }
    }
  }
}

//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView()
//  }
//}
