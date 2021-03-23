//
//  Player.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 22/03/2021.
//

import Foundation

class Player/*: Equatable*/ {
    /*static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.number == rhs.number
    }*/
    
    var cards: [Card]
    var number: Int
    
    init(number: Int) {
        self.number = number
        self.cards = []
    }
    
    func playCard() -> Card? {
        if !cards.isEmpty {
            return cards.removeFirst()
        }
        else {
            return nil
        }
    }
    
}
