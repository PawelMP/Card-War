//
//  Card.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 22/03/2021.
//

import Foundation

struct Card {
    var rank: Rank
    var suit: Suit
    var back: Color
    
    init(rank: Rank, suit: Suit, back: Color) {
        self.rank = rank
        self.suit = suit
        self.back = back
    }
    
}

struct Deck {
    static func createDeck(color: Color) -> [Card] {
        var deck = [Card]()
        for rank in Rank.allCases {
            for suit in Suit.allCases {
                deck.append(Card(rank: rank, suit: suit, back: color))
            }
        }
        return deck
    }

}

enum Suit: String, CaseIterable {
    case Club = "C", Diamonds = "D", Hearts = "H", Spades = "S"
}

enum Rank: Int, CaseIterable {
    case Two = 2, Three//, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace
}

enum Color: String{
    case blue = "blue_back", red = "red_back"
}

