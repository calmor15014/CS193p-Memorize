//
//  MemoryGame.swift
//  Memorize
//
//  Created by James Spece on 10/9/20.
//
//  Model for the Memorize App

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        // Choose only does something if we can find the card, and the card is not face up
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].hasBeenSeen || cards[potentialMatchIndex].hasBeenSeen {
                    score -= 1
                } else {
                    cards[chosenIndex].hasBeenSeen = true
                    cards[potentialMatchIndex].hasBeenSeen = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // Create empty array
        cards = Array<Card>()
        // Loop through all of the pairs requeted
        for pairIndex in 0..<numberOfPairsOfCards {
            // Get the content from the calling function
            let content = cardContentFactory(pairIndex)
            // Add two cards with the same content
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        // Shuffle the cards (Lecture 2 homework item #2)
        cards.shuffle()
    }
    
    // Define what a card is, including a Type Parameter content var
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
