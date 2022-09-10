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
                        themeStore.insertTheme(name: "", color: Color.black, emojis: [], numberOfPairs: 8)
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
                    gameVM.selectedTheme = themeStore.theme(at: index)
                    isActiveNavigationLink = true
                } label: {
                    VStack(alignment: .leading) {
                        Text(themeStore.theme(at: index).name)
                            .foregroundColor(themeStore.theme(at: index).color)
                            .font(.headline)
                        Text(themeStore.theme(at: index).stringEmojis)
                        Text("\(themeStore.theme(at: index).numberOfPairs)")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    .gesture(editMode == .active ? tap(index: index) : nil)
                }

            }
        }
        .onDelete { indexSet in
            themeStore.themes.remove(at: indexSet.first!)
        }
        .onMove { indexSet, newPosition in
            themeStore.themes.move(fromOffsets: indexSet, toOffset: newPosition)
        }
        .sheet(item: $selectedTheme) { theme in
            ThemeEditor(theme: $themeStore.themes[themeStore.themes.firstIndex(where: {$0.id == theme.id})!])
        }
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

