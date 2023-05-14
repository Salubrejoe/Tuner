//
//  PitchManager.swift
//  TunerTest
//
//  Created by Lore P on 20/04/2023.
//

import Foundation
import Beethoven
import Pitchy

class PitchManager: ObservableObject, PitchEngineDelegate {
  
  @Published var pitchString = ""
  @Published var pitchFrequency = 0.0
  @Published var offsetPercentage = 0.0
  @Published var offsetCents = 0.0
  
  func pitchEngine(_ pitchEngine: Beethoven.PitchEngine, didReceivePitch pitch: Pitchy.Pitch) {
    pitchString = pitch.note.string
    pitchFrequency = pitch.wave.frequency
    offsetPercentage = pitch.closestOffset.percentage
    offsetCents = pitch.closestOffset.cents
    
  }
  
  func pitchEngine(_ pitchEngine: Beethoven.PitchEngine, didReceiveError error: Error) {
    print(error)
  }
  
  func pitchEngineWentBelowLevelThreshold(_ pitchEngine: Beethoven.PitchEngine) {
    print("Below level threshold")
  }
}
