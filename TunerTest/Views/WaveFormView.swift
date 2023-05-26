
import SwiftUI
import Pitchy

struct WaveFormView: View {
  @State private var phase = 0.0
  let amplitude: Double
  let frequency: Double
  let waveColor: Color
  let echoes: Double
  
  var body: some View {
    ZStack {
      ForEach(0..<5) { i in
        Wave(amplitude: amplitude, frequency: frequency, phase: self.phase)
          .stroke(waveColor.opacity((Double(i)/abs(echoes))), lineWidth: 2)
          .offset(y: -CGFloat(i) * CGFloat(echoes))
      }
      .mask {
        LinearGradient(gradient: Gradient(colors: [.clear, .white, . clear]), startPoint: .leading, endPoint: .trailing)
      }
    }
    .onAppear {
      withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
        self.phase = .pi * 2
      }
    }
  }
}

struct WaveFormView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      
      WaveFormView(amplitude: 10,
                   frequency: 110,
                   waveColor: .secondary,
                   echoes: 1)
      WaveFormView(amplitude: 10,
                   frequency: 170,
                   waveColor: .secondary,
                   echoes: 1)
      
    }//: Waves
    .opacity(0.2)
  }
}
