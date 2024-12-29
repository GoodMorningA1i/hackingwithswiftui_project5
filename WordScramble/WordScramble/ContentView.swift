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
                        .textInputAutocapitalization(.never)
                        .onSubmit(addNewWord)
                        .onAppear(perform: startGame)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
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
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: String.Encoding.utf8) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
            fatalError("Can locate but not load start.txt into string")
        }
        
        fatalError("Could not locate start.txt from bundle")
    }
        
}

#Preview {
    ContentView()
}
