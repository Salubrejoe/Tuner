//
//  NotesView.swift
//  TunerTest
//
//  Created by Lore P on 26/05/2023.
//

import SwiftUI
import Pitchy

struct ViewModel {
  var notesArray: [Note] = []
  
  init() {
    do {
      for index in -40...20 {
        let note = try Note(index: index)
        notesArray.append(note)
      }
    } catch {
      print("An error occurred: \(error)")
    }
  }
}


struct NotesView: View {
  let notes = ViewModel().notesArray
  @State private var currentNote: Int = 0
  
  var body: some View {
    
    VStack {
      WaveFormView(amplitude: 50, frequency: notes[currentNote].frequency, waveColor: .white, echoes: 5)
      
      Spacer()
      
      Stepper("Select note: \(notes[currentNote].letter.rawValue)", value: $currentNote, in: 0...60)
        .padding()
    }
  }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
