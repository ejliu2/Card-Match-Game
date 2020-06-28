//
//  EmojiCardMatch.swift
//  Card Match
//
//  Created by Eric Liu on 2020-06-03.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import SwiftUI

class EmojiCardMatchGame: ObservableObject {
    // We can also use private(set). Set prevents changes by other classes/objects but allows this class to make changes
    // @Published -> wrapper, everytime this var changes, then published called objectWillChange.send()
    @Published private var game: CardMatchGame<String>
    private(set) var currentTheme: Theme
    
    init() {
        currentTheme = EmojiCardMatchGame.pickTheme()
        game = EmojiCardMatchGame.createCardMatchGame(withTheme: currentTheme)
    }
    
    private static func pickTheme() -> Theme {
        func randomNumberOfPairs() -> Int { return Int.random(in: 2...6) }
        let availableThemes: [Theme] = [
            Theme(id: 1, themeName: "Halloween", textColor: Color.orange, numberOfCards: randomNumberOfPairs(), cardColour: Gradient(colors: [Color.orange, Color.black]), emojis: ["👻", "🎃", "🕷", "🕸", "💀", "😈", "😺", "🧛🏻", "🧙‍♀️", "🧟", "🦇", "🌙"]),
            Theme(id: 2, themeName: "Animal", textColor: Color.yellow, numberOfCards: randomNumberOfPairs(), cardColour: Gradient(colors: [Color.yellow, Color.orange]), emojis: ["🐶", "🐱", "🐭", "🦊", "🐷", "🐹", "🐵", "🐨", "🐻", "🐮", "🐸", "🐼"]),
            Theme(id: 3, themeName: "Smiley", textColor: Color.purple, numberOfCards: randomNumberOfPairs(), cardColour: Gradient(colors: [Color.purple, Color.black]), emojis: ["😀", "😅", "😇", "😍", "😛", "😎", "🧐", "😭", "😡", "😱", "🤢", "👿"]),
            Theme(id: 4, themeName: "Fruit", textColor: Color.green, numberOfCards: randomNumberOfPairs(), cardColour: Gradient(colors: [Color.red, Color.green]), emojis: ["🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🍓", "🍒", "🍍", "🥥", "🥝", "🥭"]),
            Theme(id: 5, themeName: "Food", textColor: Color.red, numberOfCards: randomNumberOfPairs(), cardColour: Gradient(colors: [Color.red, Color.yellow]), emojis: ["🧀", "🥚", "🍔", "🍟", "🧇", "🥨", "🌮", "🍣", "🍲", "🍙", "🥗", "🍕"]),
            Theme(id: 6, themeName: "Sport", textColor: Color.blue, numberOfCards: randomNumberOfPairs(), cardColour: Gradient(colors: [Color.green, Color.blue]), emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🥏", "🎱", "🏓", "🏸", "🏒", "🥍"])
        ]
        let pickRandomTheme = Int.random(in: 0..<availableThemes.count)
        return availableThemes[pickRandomTheme]
    }
    
    private static func createCardMatchGame(withTheme theme: Theme) -> CardMatchGame<String> {
        let randomNumberOfPairs = theme.numberOfCards ?? Int.random(in: 2...5)
        let emojis = theme.emojis.shuffled()
        return CardMatchGame<String>(numberOfPairsOfCards: randomNumberOfPairs) { pairIndex in
            return emojis[pairIndex]
            // return subsetEmojis[pairIndex]
        }
    }
    
    // MARK: - Themes
    struct Theme : Identifiable {
        let id: Int
        let themeName: String
        let textColor: Color
        let numberOfCards: Int?
        let cardColour: Gradient
        let emojis: [String]
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<CardMatchGame<String>.Card> {
        return game.cards
    }
    
    var score: Double {
        return game.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: CardMatchGame<String>.Card) {
        game.choose(card)
    }
    
    func newCardMatchGame() -> Void {
        self.currentTheme = EmojiCardMatchGame.pickTheme()
        self.game = EmojiCardMatchGame.createCardMatchGame(withTheme: currentTheme)
    }
}
