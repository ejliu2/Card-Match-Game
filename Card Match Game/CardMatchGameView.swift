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
        HStack {
            ForEach(gameType.cards) { card in
                CardView(card: card).onTapGesture {
                    self.gameType.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
        }
}

struct CardView: View {
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
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardMatchGameView(gameType: EmojiCardMatchGame())
    }
}
