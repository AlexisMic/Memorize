//
//  ThemesManager.swift
//  Memorize
//
//  Created by Alexis Schotte on 9/6/22.
//

import SwiftUI

struct ThemesManager: View {
    
    @EnvironmentObject var themeStore: ThemeStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach (themeStore.themes) { theme in
                    NavigationLink(destination: {
                        //
                    }, label: {
                        VStack(alignment: .leading) {
                            Text(theme.name!)
                                .font(.headline)
                            Text(themeStore.stringEmojis(theme.emojis!))
                        }
                    })
                }
            }
            .navigationTitle("Themes")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct ThemeManager_Previews: PreviewProvider {
    static var previews: some View {
        ThemesManager()
            .environmentObject(ThemeStore(name: "Test"))
    }
}
