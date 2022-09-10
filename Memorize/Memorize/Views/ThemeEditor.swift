//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Alexis Schotte on 9/6/22.
//

import SwiftUI

struct ThemeEditor: View {
    
    @Binding var theme: Theme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                nameSection
                emojiSection
                countSection
                colorSection
            }
            .navigationTitle("Theme \(theme.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                }

            }
        }
    }
    
    private var nameSection: some View {
        Section("Name") {
            TextField("Name", text: $theme.name)
        }
    }
    
    @State private var emojisToAdd: String = ""
    
    private var emojiSection: some View {
        Section {
            TextField("Add emojis", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { newValue in
                    let arrayOfStrings = Array(newValue)
                    let newEmojis = arrayOfStrings.filter({$0.isEmoji})
                    for emoji in newEmojis {
                        if !theme.emojis.contains(String(emoji)) {
                            withAnimation {
                                theme.emojis.append(String(emoji))
                            }
                        }
                    }
                }

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40), spacing: 10)]) {
                ForEach (theme.emojis, id:\.self) { emoji in
                    Text(emoji)
                        .font(.title)
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll(where: {$0 == emoji})
                            }
                        }
                }
            }

        } header: {
            HStack {
                Text("Emojis")
//                Spacer()
//                Button("Add") {
//                    addEmoji()
//                }
//                .padding(.horizontal)
            }
        } footer: {
            Text("Tap the emoji to remove it")
        }

    }
    
    private func addEmoji() {
        
    }
    
    private var countSection: some View {
        Section("Number of pairs") {
            Stepper("\(theme.numberOfPairs)", value: $theme.numberOfPairs, in: 2...30)
        }
    }
    
    private var colorSection: some View {
        Section("Color") {
            ColorPicker(selection: $theme.color) {
                HStack {
                    Image(systemName: "rectangle.portrait.fill")
                        .font(.title)
                    Text("Card background color")
                }
                .foregroundColor(theme.color)
            }
        }
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore(name: "Test").theme(at: 0)))
    }
}
