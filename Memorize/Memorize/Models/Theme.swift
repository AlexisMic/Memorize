//
//  Theme.swift
//  Memorize
//
//  Created by Alexis Schotte on 29/07/2022.
//

import Foundation
import SwiftUI

struct Theme: Identifiable, Equatable, Hashable {

    var id: Int
    var name: String
    var color: Color
    var emojis: Array<String>
    var numberOfPairs: Int
    
    var stringEmojis: String {
        var emojisString = ""
        for emoji in emojis {
            emojisString += emoji
        }
        return emojisString
    }
    
    mutating func removeEmoji(emoji: String) {
        emojis.removeAll(where: {$0 == emoji})
    }
    
}
