
import SwiftUI
import Pitchy

struct WaveFormView: View {
  @State private var phase = 0.0
  let amplitude: Double
  let frequency: Double
  let waveColor: Color
  let echoes: Int
  
  var body: some View {
    ZStack {
      ForEach(0..<5) { i in
        Wave(amplitude: amplitude, frequency: frequency, phase: self.phase)
          .stroke(waveColor.opacity(Double(i)/Double(echoes)), lineWidth: 5)
          .offset(y: CGFloat(i) * CGFloat(echoes*2))
      }
      .mask {
        LinearGradient(gradient: Gradient(colors: [.clear, .white, . clear]), startPoint: .leading, endPoint: .trailing)
      }
    }
    .background(.clear)
    .ignoresSafeArea()
    .onAppear {
      withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
        self.phase = .pi * 2
      }
    }
  }
}

struct WaveFormView_Previews: PreviewProvider {
  static var previews: some View {
    WaveFormView(amplitude: 50,
                 frequency: 440,
                 waveColor: .primary,
                 echoes: 4)
  }
}
