//
//  Extensions.swift
//  Memorize
//
//  Created by Alexis Schotte on 8/19/22.
//

import SwiftUI


extension View {
    // removed , gradient: LinearGradient
    func cardify(isFacedUp: Bool, cardColor: Color) -> some View {
        self.modifier(Cardify(isFacedUp: isFacedUp, cardColor: cardColor))
    }
}
