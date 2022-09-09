//
//  ThemesManager.swift
//  Memorize
//
//  Created by Alexis Schotte on 9/6/22.
//

import SwiftUI

struct ThemesManager: View {
    
    @EnvironmentObject var themeStore: ThemeStore
    @State private var editMode: EditMode = .inactive {
        didSet {
            print(editMode)
        }
    }
    @ObservedObject var gameVM: EmojiMemoryGame
    @State private var isActiveNavigationLink = false
    
    
    
    var body: some View {
        NavigationView {
            List {
                listOfThemes
            }
            .navigationTitle("Themes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
//                        ThemeEditor(theme: $themeStore.themes[0])
                        ThemeEditor()
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
                        Text(themeStore.theme(at: index).name!)
                            .foregroundColor(.black)
                            .font(.headline)
                        Text(themeStore.stringEmojis(themeStore.theme(at: index).emojis!))
                    }
                    .padding(.horizontal)
                }

            }
//            NavigationLink(destination: {
//                destinationView(index: index)
//            }, label: {
//                VStack(alignment: .leading) {
//                    Text(themeStore.theme(at: index).name!)
//                        .font(.headline)
//                    Text(themeStore.stringEmojis(themeStore.theme(at: index).emojis!))
//                }
////                .gesture(editMode == .inactive ? tap : nil)
//            })
        }
        .onDelete { indexSet in
            themeStore.themes.remove(at: indexSet.first!)
        }
        .onMove { indexSet, newPosition in
            themeStore.themes.move(fromOffsets: indexSet, toOffset: newPosition)
        }
    }
    
    private var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded {
                print("tapped")
            }
    }
    
    @ViewBuilder
    private func destinationView(index: Int) -> some View {
        if editMode == .inactive {
            EmojiMemoryGameView(gameVM: gameVM)
        } else {
            ThemeEditor()
        }
    }
}



struct ThemeManager_Previews: PreviewProvider {
    static var previews: some View {
        ThemesManager(gameVM: EmojiMemoryGame())
            .environmentObject(ThemeStore(name: "Test"))
    }
}



// navegation Link
//    .onDisappear {
//        print("ondisappear \(themeStore.theme(at: index).name!)")
//        gameVM.selectedTheme = themeStore.theme(at: index)
//    }

