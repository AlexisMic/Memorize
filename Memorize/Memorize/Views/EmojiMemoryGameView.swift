//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Alexis Schotte on 18/07/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
        
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var gameVM: EmojiMemoryGame
    
    @State private var dealt = Set<Int>()
    
    @Namespace private var dealingCardsNamespace
    
    private func deal(_ card: Card) {
        dealt.insert(card.id)
    }
    
    private func isUnDealt(_ card: Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(_ card: Card) -> Animation {
        var delay = 0.0
        if let index = gameVM.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index)  * (2.0 / Double(gameVM.cards.count))
        }
        return Animation.easeInOut(duration: 2).delay(delay)
    }
    
    private func calcZIndex(_ card: Card) -> Double {
        -Double(gameVM.cards.firstIndex(where: { card.id == $0.id }) ?? 0)
        
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    titleAndPoints
                    gameBoard
                    buttons
                }
                .padding(.horizontal)
                deckBoard
            }
            .navigationTitle("Game")
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    private var titleAndPoints: some View {
        VStack {
            Text("Memorize the \(gameVM.selectedTheme.name)")
                .font(.largeTitle)
            Text("Points: \(gameVM.points)")
                .font(.headline)
        }
    }
    
    private var deckBoard: some View {
        ZStack {
            ForEach(gameVM.cards.filter(isUnDealt)) { card in
                CardView(card, gameVM.selectedTheme.color)
                    .matchedGeometryEffect(id: card.id, in: dealingCardsNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .identity))
                    .zIndex(calcZIndex(card))
            }
        }
        .frame(width: 60, height: 90)
        .onTapGesture {
            for card in gameVM.cards {
                withAnimation(dealAnimation(card)) {
                    deal(card)
                }
            }
        }
        
    }
    
    private var gameBoard: some View {
        AspectVGrid(items: gameVM.cards, aspectRatio: 2/3) { card in
            if isUnDealt(card) || (card.isMatched && !card.isFacedUp) {
                Color.clear
            } else {
                // removed , gradient: gameVM.themeGradient
                CardView(card, gameVM.selectedTheme.color)
                    .padding(4)
                    .matchedGeometryEffect(id: card.id, in: dealingCardsNamespace)
                    .transition(AnyTransition.asymmetric(insertion: AnyTransition.identity, removal: AnyTransition.scale).animation(.easeInOut(duration: 2)))
                    .zIndex(calcZIndex(card))
                    .onTapGesture {
                        withAnimation(Animation.easeInOut) {
                            gameVM.choose(card)
                        }
                    }
            }
        }
    }
    
    private var buttons: some View {
        HStack {
            // Theme Manager Button
            NavigationLink {
                ThemesManager(gameVM: gameVM)
            } label: {
                VStack {
                    Image(systemName: "slider.horizontal.3")
                        .font(.largeTitle)
                    Text("Themes")
                        .font(.caption)
                }
            }
            Spacer()
            // New Game Button
            Button {
                withAnimation(Animation.easeInOut(duration: 3)) {
                    dealt.removeAll()
                    gameVM.newGame(theme: gameVM.selectedTheme)
                }
            } label: {
                VStack {
                    Image(systemName: "plus.circle")
                        .font(.largeTitle)
                    Text("New Game")
                        .font(.caption)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    
    typealias Card = MemoryGame<String>.Card
    
    init(_ card: Card, _ color: Color) {
        self.card = card
        self.cardColor = color
    }
    
    private let card: Card
    private let cardColor: Color
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear(){
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                    }
                }
                .padding(5)
                .opacity(0.5)
                .foregroundColor(.red)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: card.isMatched)
                // .animation is deprecated
//                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        .font(Font.system(size: Constants.fontSize))
                        .scaleEffect(fontScale(size: geometry.size))
            }
            .cardify(isFacedUp: card.isFacedUp, cardColor: cardColor)
        }
    }
    
    private func fontScale(size: CGSize) -> CGFloat {
        min(size.width, size.height) / (Constants.fontSize / Constants.fontScale)
    }
    
    // removed because .font can't be animated
//    private func fontSize(size: CGSize) -> Font {
//        Font.system(size: min(size.width, size.height) * Constants.fontScale)
//    }
    
    struct Constants {
        static let fontScale: CGFloat = 0.65
        static let fontSize: CGFloat = 32
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return Group {
            EmojiMemoryGameView(gameVM: game)
            .previewInterfaceOrientation(.portrait)
        
            EmojiMemoryGameView(gameVM: game)
            .preferredColorScheme(.dark)
        }
    }
}





