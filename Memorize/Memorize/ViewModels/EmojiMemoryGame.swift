//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ana Clara Schotte on 25/07/2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
//    @EnvironmentObject var themeStore: ThemeStore
    
    typealias Card = MemoryGame<String>.Card
    
//    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
//        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
//            theme.emojis![pairIndex]
//        }
//    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame(theme: theme)
    }
    
    @Published private var model: MemoryGame<String>
    
    var theme: Theme {
        model.theme
    }
    
    var points: Int {
        model.points
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    init() {
        model = MemoryGame() //EmojiMemoryGame.createMemoryGame()
    }
    
    //MARK: Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame() {
        model = MemoryGame(theme: theme) //EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
}
