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
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .highPriorityGesture(DragGesture(minimumDistance: 0))
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
                        checkErrors()
                    } label: {
                        Text("Done")
                    }

                }
            }
        }
        .alert("Attention", isPresented: $showAlert) {
                Button(role: .destructive) {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Delete")
                }
        } message: {
            Text("Your Theme must have a name and at least 2 emojis or it will be deleted.")
        }
    }

    private func checkErrors() {
        if theme.name == "" || theme.emojis.count < 2 {
            showAlert = true
        } else {
            presentationMode.wrappedValue.dismiss()
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
                    addEmoji(newValue)
                }

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40), spacing: 10)]) {
                ForEach (theme.emojis, id:\.self) { emoji in
                    Text(emoji)
                        .font(.title)
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                if theme.emojis.count > 2 {
                                    theme.emojis.removeAll(where: {$0 == emoji})
                                }
                            }
                        }
                }
            }

        } header: {
            HStack {
                Text("Emojis")
            }
        } footer: {
            Text("Tap the emoji to remove it")
        }

    }
    
    private func addEmoji(_ newValue: String) {
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
    
    @ViewBuilder
    private var countSection: some View {
        let maxPairs = theme.emojis.count > 1 ? theme.emojis.count : 2
        Section("Number of pairs") {
            Stepper("\(theme.numberOfPairs)", value: $theme.numberOfPairs, in: 2...maxPairs)
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
