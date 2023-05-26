//
//  Wave.swift
//  TunerTest
//
//  Created by Lore P on 26/05/2023.
//

import SwiftUI

struct Wave: Shape {
  
  var amplitude: Double
  var frequency: Double
  var phase: Double
  
  var animatableData: Double {
    get { phase } // When we reading the value get phase
    set { self.phase = newValue}
  }
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath()
    let width = Double(rect.width)
    let height = Double(rect.height)
    let midWidth = width / 2
    let midHeight = height / 2
    
    let oneOverMidWIdth = 1 / midWidth
    
    let wavelenght = width / (frequency / 10)
    
    path.move(to: CGPoint(x: 0, y: midHeight))
    
    for x in stride(from: 0, to: width, by: 2) {
      let relativeX = x / wavelenght
      
      let distanceFromMidwidth = x - midWidth
      // Let's renormalize (from -1 to 1) that:
      let normalDistance = 1 / midWidth * distanceFromMidwidth
      let parabola = -(normalDistance * normalDistance) + 1
      
      let sine = sin(relativeX + phase) // Offset based on phase
      let y = parabola * sine * amplitude + midHeight // 0 is halfway down our screen
      path.addLine(to: CGPoint(x: x, y: y))
    }
    
    return Path(path.cgPath)
  }
}
