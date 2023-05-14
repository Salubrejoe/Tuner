//
//  GradientTestView.swift
//  TunerTest
//
//  Created by Lore P on 20/04/2023.
//

import SwiftUI

struct GradientTestView: View {
  @State private var value = 0.0
  
  var body: some View {
    ZStack {
//      AngularGradient(stops: [
//        .init(color: .green, location: value),
//        .init(color: .red, location: value)
//
//      ], center: .top)
      
      VStack {
        Gauge(value: value, in: 0...0.5) {
          Text("")
        }
        .gaugeStyle(.accessoryCircular)
        .scaleEffect(5)
        .offset(y: -80)
        .shadow(color: .red, radius: 5)
        
        
        Slider(value: $value, in: 0...0.5)
          .onAppear {
            print(value)
        }
      }
    }
  }
}

struct GradientTestView_Previews: PreviewProvider {
  static var previews: some View {
    GradientTestView()
  }
}
