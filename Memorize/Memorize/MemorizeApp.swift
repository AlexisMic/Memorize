//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Alexis Schotte on 18/07/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var emojiMemoryGame = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore(name: "default")
    var body: some Scene {
        WindowGroup {
            ThemesManager(gameVM: emojiMemoryGame)
                .environmentObject(themeStore)
        }
    }
}
