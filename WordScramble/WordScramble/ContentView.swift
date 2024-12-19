//
//  ContentView.swift
//  WordScramble
//
//  Created by Ali Syed on 2024-12-07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .onSubmit(addNewWord)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        Text(word)
                    }
                }
            }
            .navigationTitle(rootWord)
        }
    }
    
    func addNewWord() {
        //lowercase and trim any white space and new lines, this is to deal with duplicates
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit if the string is empty after being lowercased and trimmed
        guard answer.count > 0 else { return }
        
        //extra validation to come
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
        
}

#Preview {
    ContentView()
}
