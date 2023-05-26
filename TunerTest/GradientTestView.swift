//
//  GradientTestView.swift
//  TunerTest
//
//  Created by Lore P on 20/04/2023.
//

import SwiftUI

struct CircularGaugeView: View {
  private let minValue: Double
  private let maxValue: Double
  @State private var currentValue: Double
  
  private var progress: Double {
    let clampedValue = min(max(currentValue, minValue), maxValue)
    return (clampedValue - minValue) / (maxValue - minValue)
  }
  
  private var strokeStyle: StrokeStyle {
    StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round)
  }
  
  private var foregroundColor: Color {
    Color.green
  }
  
  private var backgroundColor: Color {
    Color.gray.opacity(0.3)
  }
  
  init(minValue: Double, maxValue: Double, currentValue: Double) {
    self.minValue = minValue
    self.maxValue = maxValue
    self.currentValue = currentValue
  }
  
  var body: some View {
    GeometryReader { geometry in
      let size = min(geometry.size.width, geometry.size.height)
      
      VStack {
        Slider(value: $currentValue, in: -100...100)
        
        ZStack {
          Circle()
            .strokeBorder(backgroundColor, style: strokeStyle)
          
          Circle()
            .trim(from: 0.0, to: CGFloat(progress))
            .stroke(foregroundColor, style: strokeStyle)
            .rotationEffect(Angle(degrees: -90))
            .animation(.easeInOut)
          
          // Pointer
          Path { path in
            path.move(to: CGPoint(x: size / 2, y: 0))
            path.addLine(to: CGPoint(x: size / 2 - 10, y: size / 2))
            path.addLine(to: CGPoint(x: size / 2 + 10, y: size / 2))
            path.closeSubpath()
          }
          .fill(.red)
          .rotationEffect(Angle(degrees: 180 * progress), anchor: .bottom)
          
          Text(String(format: "%.1f", currentValue))
            .font(.system(size: 30, weight: .bold, design: .default))
        }
        .frame(width: size)
      }
    }
  }
}


struct GradientTestView_Previews: PreviewProvider {
  static var previews: some View {
    CircularGaugeView(minValue: -100, maxValue: 100, currentValue: 0)
  }
}
