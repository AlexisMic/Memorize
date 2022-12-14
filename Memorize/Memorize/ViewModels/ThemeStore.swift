//
//  ThemeStore.swift
//  Memorize
//
//  Created by Alexis Schotte on 9/6/22.
//

import Foundation
import SwiftUI

class ThemeStore: ObservableObject {
    
    private var name: String
    
    @Published var themes: Array<Theme> = [] {
        didSet {
            storeUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ThemeStore" + name
    }
    
    private func storeUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
        let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(name: String) {
        self.name = name
        restoreUserDefaults()
        if themes.isEmpty {
            insertTheme(name: "Vehicles", color: Color.red, emojis: ["🚍", "✈️", "🛳", "🚂", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚨", "🚘", "🚖", "🚡", "🚠", "🚟", "🚃", "🚋", "🚞", "🚝", "🚅", "🚆", "🚊", "🛩"], numberOfPairs: 24)
            insertTheme(name: "Activities", color: Color.blue, emojis: ["⛷", "🏂", "🪂", "🏋🏻‍♀️", "🤼", "🤸🏻‍♀️", "⛹🏻", "🤾🏻", "🏌🏻", "🏇🏻", "🧘🏻‍♀️", "🏄🏻‍♂️", "🏊🏻‍♂️", "🤽🏻", "🧗🏻‍♀️", "🚴🏼"], numberOfPairs: 16)
            insertTheme(name: "Animals", color: Color.yellow, emojis: ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐹", "🐻‍❄️"], numberOfPairs: 16)
            insertTheme(name: "Fruits", color: Color.orange, emojis: ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🥥", "🍍", "🥭", "🍑", "🥑", "🥝"], numberOfPairs: 16)
            insertTheme(name: "Food", color: Color.purple, emojis: ["🍅", "🍆", "🥦", "🥬", "🥒", "🌶", "🫑", "🌽", "🥕", "🫒", "🧅", "🥔"], numberOfPairs: 12)
            insertTheme(name: "Flags", color: Color.green, emojis: ["🇧🇷", "🇦🇷", "🇧🇪", "🇨🇳", "🇨🇮", "🇫🇷", "🇪🇺", "🇬🇷", "🇮🇪", "🇮🇹", "🇮🇱", "🇯🇵", "🇱🇧", "🇱🇺", "🇳🇴", "🇵🇹", "🇿🇦", "🇬🇧", "🇺🇸"], numberOfPairs: 18)
        }
    }
    
    //MARK: Intents
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(0, index), themes.count - 1)
        return themes[safeIndex]
    }
    
    func insertTheme(name: String, color: Color, emojis: Array<String>, numberOfPairs: Int) {
        let uniqueId = themes.count
        let newTheme = Theme(id: uniqueId, name: name, rgbaColor: RGBAColor(color: color), emojis: emojis, numberOfPairs: numberOfPairs)
        themes.append(newTheme)
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int? {
        if themes.count > 1 {
            let safeIndex = min(max(0, index), themes.count - 1)
            themes.remove(at: safeIndex)
            return safeIndex
        }
        return nil
    }
    
}
