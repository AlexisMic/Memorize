//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ana Clara Schotte on 18/07/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var emojiMemoryGame = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore(name: "default")
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(gameVM: emojiMemoryGame)
                .environmentObject(themeStore)
        }
    }
}
