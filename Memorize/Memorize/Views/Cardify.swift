//
//  Cardify.swift
//  Memorize
//
//  Created by Alexis Schotte on 8/19/22.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    
    @EnvironmentObject var themeStore: ThemeStore
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
//    var gradient: LinearGradient
    var rotation: Double
    var cardColor: Color
    
    // removed , gradient: LinearGradient
    init(isFacedUp: Bool, cardColor: Color) {
        self.rotation = isFacedUp ? 0 : 180
        self.cardColor = cardColor
//        self.gradient = gradient
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            if rotation < 90 {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape.strokeBorder(lineWidth: Constants.lineWidth)
                
            } else {
                shape.fill(cardColor)
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}
