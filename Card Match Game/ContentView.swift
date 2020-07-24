//
//  ContentView.swift
//  Card Match
//
//  Created by Eric Liu on 2020-06-02.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import SwiftUI

struct CardMatchGameView: View {
    var gameType: EmojiCardMatchGame
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
            .font(gameType.cards.count < 5 ? Font.largeTitle : Font.title)
        }
}

struct CardView: View {
    var card: CardMatchGame<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3).foregroundColor(Color.orange).padding() // 10 point font
                Text(card.content).padding().font(Font.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardMatchGameView(gameType: EmojiCardMatchGame())
    }
}
