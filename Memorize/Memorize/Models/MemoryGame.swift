//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ana Clara Schotte on 25/07/2022.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private(set) var points = 0
    
    var theme: Theme
    
    private var indexOfTheOnlyCardFaceUp: Int? {
        get { cards.indices.filter { cards[$0].isFacedUp }.onlyIfThereIsOne }
        set { cards.indices.forEach { cards[$0].isFacedUp = ($0 == newValue)}}
    }
    
    mutating func choose(_ card: Card) {
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
        !cards[chosenIndex].isFacedUp,
        !cards[chosenIndex].isMatched {
            if let potencialMatchIndex = indexOfTheOnlyCardFaceUp {
                if cards[chosenIndex].content == cards[potencialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potencialMatchIndex].isMatched = true
                    points += 1
                } else {
                    if cards[chosenIndex].hasAlreadyFacedUp {
                        points -= 1
                    }
                    if cards[potencialMatchIndex].hasAlreadyFacedUp {
                        points -= 1
                    }
                    cards[chosenIndex].hasAlreadyFacedUp = true
                    cards[potencialMatchIndex].hasAlreadyFacedUp = true
                }
                cards[chosenIndex].isFacedUp = true
            } else {
                indexOfTheOnlyCardFaceUp = chosenIndex
            }
            
        }
    }
    
    init() {
        self.theme = Theme(id: 9999, name: "Activities", color: Color.red, emojis: ["⛷", "🏂", "🪂", "🏋🏻‍♀️", "🤼", "🤸🏻‍♀️", "⛹🏻", "🤾🏻", "🏌🏻", "🏇🏻", "🧘🏻‍♀️", "🏄🏻‍♂️", "🏊🏻‍♂️", "🤽🏻", "🧗🏻‍♀️", "🚴🏼"], numberOfPairs: 16)
        cards = []
        createDeckOfCards(theme: theme)
    }
    
    init(theme: Theme) {
        self.theme = theme
        cards = []
        createDeckOfCards(theme: theme)
    }
    
    mutating private func createDeckOfCards(theme: Theme) {
        // add cards
        for pairIndex in 0..<self.theme.numberOfPairs {
            let content = theme.emojis![pairIndex]
            cards.append(Card(id: pairIndex * 2, content: content as! CardContent))
            cards.append(Card(id: pairIndex * 2 + 1, content: content as! CardContent))
        }
        cards.shuffle()
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let id: Int
        var isFacedUp = false {
            didSet {
                if isFacedUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        var hasAlreadyFacedUp = false
        let content: CardContent
        
        
        // **** Time Calculations ****
        
        var bonusTimeLimit: TimeInterval = 6
        
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var isConsumingBonusTime: Bool {
            isFacedUp && !isMatched && bonusTimeRemaining > 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
    }
    
}

extension Array {
    var onlyIfThereIsOne: Element? { count == 1 ? first : nil }
}


