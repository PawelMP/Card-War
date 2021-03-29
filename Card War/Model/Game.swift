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
    
    var gameType: GameType = .normal
    
    init() {
        self.firstPlayerCardsStack = []
        self.secondPlayerCardsStack = []
    }
    
    func startGame(players: [Player]) {
        
        func divideCards(for players: [Player]) {
            var deck = Deck.createDeck(color: .blue)
            deck.shuffle()
            let cardsNumber = deck.count/players.count
            for player in players {
                for _ in 1...cardsNumber {
                    player.cards.append(deck.removeLast())
                }
            }
        }

        self.firstPlayerCardsStack = []
        self.secondPlayerCardsStack = []
        divideCards(for: players)
    }
    
    func checkCards(firstPlayer: Player, secondPlayer: Player, dealEnded: () -> Void) {
        func resetCards() {
            firstPlayerCardOnTable = nil
            secondPlayerCardOnTable = nil
            
            firstPlayerCardsStack = []
            secondPlayerCardsStack = []
            
            gameType = .normal
        }
        
        func firstPlayerWinDeal() {
            firstPlayer.cards += firstPlayerCardsStack
            firstPlayer.cards += secondPlayerCardsStack
        }
        
        func secondPlayerWinDeal() {
            secondPlayer.cards += firstPlayerCardsStack
            secondPlayer.cards += secondPlayerCardsStack
        }
        
        if let firstPlayerCard = firstPlayerCardOnTable, let secondPlayerCard = secondPlayerCardOnTable {
            if firstPlayerCard.rank.rawValue == secondPlayerCard.rank.rawValue {
                print("DRAW")
                if (firstPlayer.cards.isEmpty == true && secondPlayer.cards.isEmpty == true) || (firstPlayer.cards.count == 1 && secondPlayer.cards.count == 1) {
                    print("Both players don't have enough cards to play war - cards go back to both players - draw")
                    firstPlayer.cards += firstPlayerCardsStack
                    secondPlayer.cards += secondPlayerCardsStack
                    
                    resetCards()
                    
                    dealEnded()
                    return
                }
                if firstPlayer.cards.isEmpty == true || firstPlayer.cards.count == 1 {
                    print("First player doesnt have enough cards to play war - loses")
                    secondPlayer.cards += firstPlayerCardsStack
                    secondPlayer.cards += secondPlayerCardsStack
                    
                    dealEnded()
                    return //np return false i w GameViewModel jezeli funkcja zwroci false to wtedy wywoluje metode z delegate powiadamiajaca o wygranej gracza
                }
                if secondPlayer.cards.isEmpty == true || secondPlayer.cards.count == 1 {
                    print("Second player doestn have enough cards to play war - loses")
                    firstPlayer.cards += firstPlayerCardsStack
                    firstPlayer.cards += secondPlayerCardsStack
                    
                    dealEnded()
                    return
                }
                
                firstPlayerCardOnTable = nil
                secondPlayerCardOnTable = nil
                gameType = .war
            }
            else if firstPlayerCard.rank.rawValue > secondPlayerCard.rank.rawValue {
                print("First player won")
                firstPlayer.cards += firstPlayerCardsStack
                firstPlayer.cards += secondPlayerCardsStack
                
                resetCards()
                print("First player cards \(firstPlayer.cards.count)")
                print("Second player cards \(secondPlayer.cards.count)")
                
                dealEnded()
            }
            else {
                print("Second player won")
                secondPlayer.cards += firstPlayerCardsStack
                secondPlayer.cards += secondPlayerCardsStack
                
                resetCards()
                print("First player cards \(firstPlayer.cards.count)")
                print("Second player cards \(secondPlayer.cards.count)")
                
                dealEnded()
            }
        }
    }
    
}

enum GameType {
    case normal
    case war
}
