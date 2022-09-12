//
//  ThemesManager.swift
//  Memorize
//
//  Created by Alexis Schotte on 9/6/22.
//

import SwiftUI

struct ThemesManager: View {
    
    @EnvironmentObject var themeStore: ThemeStore
    @State private var editMode: EditMode = .inactive
    @ObservedObject var gameVM: EmojiMemoryGame
    @State private var isActiveNavigationLink = false
    @State private var selectedTheme: Theme?
    
    var body: some View {
        NavigationView {
            List {
                listOfThemes
            }
            .navigationTitle("Themes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // creates new empty theme
                        themeStore.insertTheme(name: "New Theme", color: Color.black, emojis: [], numberOfPairs: 8)
                        selectedTheme = themeStore.themes.last
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                ToolbarItem {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    
    private var listOfThemes: some View {
        ForEach (themeStore.themes.indices, id:\.self) { index in
            
            ZStack {
                NavigationLink(isActive: $isActiveNavigationLink) {
                    destinationView(index: index)
                } label: {
                    EmptyView()
                }
                Button {
                    if gameVM.selectedTheme == themeStore.theme(at: index) {
                        gameVM.sameGame = true
                    } else {
                        gameVM.selectedTheme = themeStore.theme(at: index)
                    }
                    isActiveNavigationLink = true
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.fill")
                            .font(.largeTitle)
                            .foregroundColor(themeStore.theme(at: index).color)
                        VStack(alignment: .leading) {
                            HStack {
                                Text(themeStore.theme(at: index).name)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("\(themeStore.theme(at: index).numberOfPairs)")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .padding(.horizontal)
                            }
                            .padding(2)

                            Text(themeStore.theme(at: index).stringEmojis)
                                .lineLimit(2)
                        }
                        .padding(.horizontal)
                    .gesture(editMode == .active ? tap(index: index) : nil)
                    }
                }

            }
        }
        .onDelete { indexSet in
            themeStore.themes.remove(at: indexSet.first!)
        }
        .onMove { indexSet, newPosition in
            themeStore.themes.move(fromOffsets: indexSet, toOffset: newPosition)
        }
        .sheet(item: $selectedTheme, onDismiss: {
            // If some theme doesn't have a name or at least 2 emojis, erase it.
            themeStore.themes = themeStore.themes.filter({!$0.name.isEmpty && $0.emojis.count > 1})
            // If some theme has more pairs than emojis, adjust to max count emojis
            for index in themeStore.themes.indices {
                if themeStore.themes[index].numberOfPairs > themeStore.themes[index].emojis.count {
                    themeStore.themes[index].numberOfPairs = themeStore.themes[index].emojis.count
                }
            }
            //Sort of mode Edit after ThemeEditor View
            editMode = .inactive
        }, content: { theme in
            ThemeEditor(theme: $themeStore.themes[themeStore.themes.firstIndex(where: {$0.id == theme.id})!])
        })
    }
    
    private func tap(index: Int) -> some Gesture {
        TapGesture(count: 1)
            .onEnded {
                selectedTheme = themeStore.theme(at: index)
            }
    }
    
    @ViewBuilder
    private func destinationView(index: Int) -> some View {
        switch editMode {
        case .inactive:
            EmojiMemoryGameView(gameVM: gameVM)
        default:
            EmptyView()
        }
    }
}



struct ThemeManager_Previews: PreviewProvider {
    static var previews: some View {
        ThemesManager(gameVM: EmojiMemoryGame())
            .environmentObject(ThemeStore(name: "Test"))
    }
}

