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
        Group {
            Text("Theme: \(gameType.currentTheme.themeName)").font(Font.largeTitle).foregroundColor(gameType.currentTheme.textColor)
            //Text("Current Score: \(gameType.score.rounded())").font(Font.title)
            HStack {
                Text("Current Score: ").font(Font.largeTitle)
                Text(String(format: "%.0f", gameType.score.rounded())).font(Font.largeTitle)
            }
            
            Grid(items: gameType.cards) { card in
                CardView(gameType: self.gameType, card: card).onTapGesture {
                    self.gameType.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            Button(action: {self.gameType.newCardMatchGame()}) {
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
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).foregroundColor(gameType.currentTheme.textColor)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(gradient: gameType.currentTheme.themeColour, startPoint: .top, endPoint: .bottom))
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardMatchGameView(gameType: EmojiCardMatchGame())
    }
}
