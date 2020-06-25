//
//  EmojiCardMatch.swift
//  Card Match
//
//  Created by Eric Liu on 2020-06-03.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import Foundation

class EmojiCardMatchGame: ObservableObject {
    // We can also use private(set). Set prevents changes by other classes/objects but allows this class to make changes
    // @Published -> wrapper, everytime this var changes, then published called objectWillChange.send()
    @Published private var game: CardMatchGame<String> = EmojiCardMatchGame.createCardMatchGame()
    
    static func createCardMatchGame() -> CardMatchGame<String> {
        let randomNumberOfPairs = Int.random(in: 2...5)
        let randomTheme = Int.random(in: 0...5)
        let halloweenEmojis = ["👻", "🎃", "🕷", "🕸", "💀", "😈", "😺", "🧛🏻", "🧙‍♀️", "🧟", "🦇", "🌙"]
        let animalEmojis = ["🐶", "🐱", "🐭", "🦊", "🐷", "🐹", "🐵", "🐨", "🐻", "🐮", "🐸", "🐼"]
        let smileyEmojis = ["😀", "😅", "😇", "😍", "😛", "😎", "🧐", "😭", "😡", "😱", "🤢", "👿"]
        let fruitEmojis = ["🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🍓", "🍒", "🍍", "🥥", "🥝", "🥭"]
        let foodEmojis = ["🧀", "🥚", "🍔", "🍟", "🧇", "🥨", "🌮", "🍣", "🍲", "🍙", "🥗", "🍕"]
        let sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🥏", "🎱", "🏓", "🏸", "🏒", "🥍"]
        
        let availableThemes: [Theme] = [
        Theme(themeName: "halloween", numberOfCards: randomNumberOfPairs, themeColour: "Orange", emojis: halloweenEmojis),
        Theme(themeName: "animal", numberOfCards: randomNumberOfPairs, themeColour: "Yellow", emojis: animalEmojis),
        Theme(themeName: "smiley", numberOfCards: randomNumberOfPairs, themeColour: "Black", emojis: smileyEmojis),
        Theme(themeName: "fruit", numberOfCards: randomNumberOfPairs, themeColour: "Green", emojis: fruitEmojis),
        Theme(themeName: "food", numberOfCards: randomNumberOfPairs, themeColour: "Red", emojis: foodEmojis),
        Theme(themeName: "sport", numberOfCards: randomNumberOfPairs, themeColour: "Blue", emojis: sportEmojis)
        ]
        
        return CardMatchGame<String>(numberOfPairsOfCards: randomNumberOfPairs) { pairIndex in
            return availableThemes[randomTheme].emojis[pairIndex]
            // return subsetEmojis[pairIndex]
        }
    }
    
    // MARK: - Themes
    struct Theme {
        var themeName: String
        var numberOfCards: Int?
        var themeColour: String
        var emojis: [String]
    }

    
    // MARK: - Access to the Model
    
    var cards: Array<CardMatchGame<String>.Card> {
        return game.cards;
    }
    
    // MARK: - Intent(s)
    
    func choose(card: CardMatchGame<String>.Card) {
        game.choose(card)
    }
}
