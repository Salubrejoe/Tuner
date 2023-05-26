//
//  PitchManager.swift
//  TunerTest
//
//  Created by Lore P on 20/04/2023.
//

import Foundation
import Beethoven
import Pitchy

class PitchData: ObservableObject, PitchEngineDelegate {
  
  @Published var pitchString = ""
  @Published var pitchFrequency = 0.0
  
  @Published var offsetPercentage = 0.0
  @Published var offsetCents = 0.0
  
  @Published var closestOffsetFrequency = 0.0
  @Published var closestOffsetLetter = ""
  
  @Published var signalLevel = 0.0
  
  @Published var didReceiveError = false
  var errorMessage = ""
  
  @Published var isBelowThresholdLevel = false
  
  
  // MARK: - Tuned Bools
  var isTuned: Bool {
    offsetCents > -5.0 && offsetCents < 5.0
  }
  
  var isAlmostThereFromTheBottom: Bool {
    offsetCents <= -5.0
  }
  
  var isAlmostThereFromTheTop: Bool {
    offsetCents >= 5.0
  }
  
  var isNotThereFromTheBotton: Bool {
    offsetCents <= -20
  }
  
  var isNotThereFromTheTop: Bool {
    offsetCents >= 20
  }
  
  
  // MARK: - DELEGATE
  func pitchEngine(_ pitchEngine: Beethoven.PitchEngine, didReceivePitch pitch: Pitchy.Pitch) {
    pitchString = pitch.note.letter.rawValue
    pitchFrequency = pitch.wave.frequency
    offsetPercentage = pitch.closestOffset.percentage
    offsetCents = pitch.closestOffset.cents
    closestOffsetFrequency = pitch.closestOffset.note.frequency
    closestOffsetLetter = pitch.closestOffset.note.letter.rawValue
    signalLevel = Double(pitchEngine.signalLevel)
  }
  
  func pitchEngine(_ pitchEngine: Beethoven.PitchEngine, didReceiveError error: Error) {
    didReceiveError = true
    errorMessage = error.localizedDescription
  }
  
  func pitchEngineWentBelowLevelThreshold(_ pitchEngine: Beethoven.PitchEngine) {
    isBelowThresholdLevel = true
  }
}
