//
//  CardMatchGameView.swift
//  Card Match
//
//  Created by Eric Liu on 2020-06-02.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import SwiftUI

struct CardMatchGameView: View {
    // @ObservedObject -> indicates that var is observable and need to redraw on objectWillChange.send()
    @ObservedObject var gameType: EmojiCardMatchGame
    
    var body: some View {
        VStack {
            Text("Theme: \(gameType.currentTheme.themeName)").font(Font.largeTitle).foregroundColor(gameType.currentTheme.textColor)
            //Text("Current Score: \(gameType.score.rounded())").font(Font.title)
            HStack {
                Text("Current Score: ").font(Font.title)
                Text(String(format: "%.0f", gameType.score.rounded())).font(Font.title)
            }
            
            Grid(items: gameType.cards) { card in
                CardView(gameType: self.gameType, card: card).onTapGesture {
                    withAnimation(.linear(duration: halfsec)) {
                        self.gameType.choose(card: card)
                    }
                }
                .padding(pad)
            }
            .padding()
            
            Button(action: { withAnimation(.easeInOut(duration: halfsec)) {self.gameType.newCardMatchGame()}}) {
                Text("New Game").font(Font.largeTitle)
            }
        }
    }
}

struct CardView: View {
    var gameType: EmojiCardMatchGame
    var card: CardMatchGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(begin), endAngle: Angle.degrees(endAngle(-animatedBonusRemaining)), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(begin), endAngle: Angle.degrees(endAngle(-card.bonusRemaining)), clockwise: true)
                    }
                }
                    .padding(pad)
                    .opacity(halfTransparent)
                    .foregroundColor(gameType.currentTheme.textColor)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: halfsec).repeatCount(10, autoreverses: false) : .default)
            }
            .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
            .cardify(isFaceUp: card.isFaceUp, colour: LinearGradient(gradient: gameType.currentTheme.cardColour, startPoint: .top, endPoint: .bottom))
            .transition(AnyTransition.scale)
        }
    }
}
    
// MARK: - Drawing Constants

private func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * 0.5
}
private let halfsec: Double = 0.5
private let begin: Double = -90
private func endAngle(_ value: Double) -> Double {
    value * 360 - 90
}
private let pad: CGFloat = 5.0
private let halfTransparent: Double = 0.4

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiCardMatchGame()
        game.choose(card: game.cards[0])
        return CardMatchGameView(gameType: game)
    }
}
