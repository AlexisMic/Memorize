//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexis Schotte on 25/07/2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
        
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    
    @Published var selectedTheme: Theme {
        didSet {
            if selectedTheme != oldValue {
                newGame(theme: selectedTheme)
            }
        }
    }
    
    var points: Int {
        model.points
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    init() {
        let theme = Theme(id: 9999, name: "Activities", color: Color.red, emojis: ["⛷", "🏂", "🪂", "🏋🏻‍♀️", "🤼", "🤸🏻‍♀️", "⛹🏻", "🤾🏻", "🏌🏻", "🏇🏻", "🧘🏻‍♀️", "🏄🏻‍♂️", "🏊🏻‍♂️", "🤽🏻", "🧗🏻‍♀️", "🚴🏼"], numberOfPairs: 16)
        self.selectedTheme = theme
        model = MemoryGame(theme: theme)
    }
    
    init(_ theme: Theme) {
        self.selectedTheme = theme
        model = MemoryGame(theme: theme) //EmojiMemoryGame.createMemoryGame()
    }
    
    //MARK: Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame(theme: Theme) {
        model = MemoryGame(theme: selectedTheme) //EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
}



//    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
//        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
//            theme.emojis![pairIndex]
//        }
//    }
    
