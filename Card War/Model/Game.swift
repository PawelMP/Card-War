//
//  Game.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 23/03/2021.
//

import Foundation

class Game {
    var firstPlayerCardOnTable: Card?
    var secondPlayerCardOnTable: Card?
    
    var firstPlayerCardsStack: [Card]
    var secondPlayerCardsStack: [Card]
    
    init() {
        self.firstPlayerCardsStack = []
        self.secondPlayerCardsStack = []
    }
    
    func startGame(players: [Player]) {
        
        func divideCards(for players: [Player]) {
            var deck = Deck.createDeck(color: .blue)
            deck.shuffle()
            for player in players {
                for _ in 1...deck.count/players.count {
                    player.cards.append(deck.removeLast())
                }
            }
        }

        self.firstPlayerCardsStack = []
        self.secondPlayerCardsStack = []
        divideCards(for: players)
    }
    
    func checkCards() {
        if let firstPlayerCard = firstPlayerCardOnTable, let secondPlayerCard = secondPlayerCardOnTable {
            if firstPlayerCard.rank.rawValue == secondPlayerCard.rank.rawValue {
                print("DRAW")
            }
            else if firstPlayerCard.rank.rawValue > secondPlayerCard.rank.rawValue {
                print("First player won")
            }
            else {
                print("Second player won")
            }
        }
    }
    
}

enum GameType {
    case normal
    case war
}
