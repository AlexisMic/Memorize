//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Alexis Schotte on 9/6/22.
//

import SwiftUI

struct ThemeEditor: View {
    
    @Binding var theme: Theme
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore(name: "Test").theme(at: 0)))
    }
}
