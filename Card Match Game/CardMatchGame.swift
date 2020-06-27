//
//  CardMatch.swift
//  Card Match
//
//  Created by Eric Liu on 2020-06-03.
//  Copyright © 2020 Eric Liu. All rights reserved.
//

import Foundation

struct CardMatchGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var timeSinceLastChosen: Date?
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    private(set) var score: Double = 0.0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>() // Empty Array of Cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        // print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    self.score += max(2.0, (4.0 + timeSinceLastChosen!.timeIntervalSinceNow))
                }
                else {
                    if (cards[chosenIndex].seenBefore) {
                        self.score -= 1.0
                    }
                    if (cards[potentialMatchIndex].seenBefore) {
                        self.score -= 1.0
                    }
                    cards[chosenIndex].seenBefore = true
                    cards[potentialMatchIndex].seenBefore = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                timeSinceLastChosen = Date()
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var seenBefore: Bool = false
    }
}
