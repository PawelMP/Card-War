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
    
    var gameType: GameType
    private var warCardCounter: Int
    
    var playerThatWon: PlayerNumber?
    var message: String?
    
    init() {
        self.firstPlayerCardsStack = []
        self.secondPlayerCardsStack = []
        self.gameType = .normal
        warCardCounter = 0
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
    
    func checkCards(firstPlayer: Player, secondPlayer: Player, dealEnded: (PlayerNumber) -> Void, warExists:() -> Void) {
        func resetCards() {
            firstPlayerCardOnTable = nil
            secondPlayerCardOnTable = nil
            
            firstPlayerCardsStack = []
            secondPlayerCardsStack = []
            
            warCardCounter = 0
            
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
        
        switch gameType {
        case .normal:
            if let firstPlayerCard = firstPlayerCardOnTable, let secondPlayerCard = secondPlayerCardOnTable {
                if firstPlayerCard.rank.rawValue == secondPlayerCard.rank.rawValue {
                    print("DRAW")
                    if (firstPlayer.cards.isEmpty == true && secondPlayer.cards.isEmpty == true) || (firstPlayer.cards.count == 1 && secondPlayer.cards.count == 1) {
                        print("Both players don't have enough cards to play war - cards go back to both players - draw")
                        firstPlayer.cards += firstPlayerCardsStack
                        secondPlayer.cards += secondPlayerCardsStack
                        
                        resetCards()
                        
                        dealEnded(.nobody)
                        return
                    }
                    if firstPlayer.cards.isEmpty == true || firstPlayer.cards.count == 1 {
                        print("First player doesnt have enough cards to play war - loses")
                        secondPlayer.cards += firstPlayerCardsStack
                        secondPlayer.cards += secondPlayerCardsStack
                        
                        resetCards()
                        playerThatWon = .second
                        message = """
                        Second player won with \(secondPlayer.cards.count) points

                        First player did not have
                        enough cards to play war
                        """
                        dealEnded(.second)
                        return //np return false i w GameViewModel jezeli funkcja zwroci false to wtedy wywoluje metode z delegate powiadamiajaca o wygranej gracza
                    }
                    if secondPlayer.cards.isEmpty == true || secondPlayer.cards.count == 1 {
                        print("Second player does not have enough cards to play war - loses")
                        firstPlayer.cards += firstPlayerCardsStack
                        firstPlayer.cards += secondPlayerCardsStack
                        
                        resetCards()
                        playerThatWon = .first
                        message = """
                        First player won with \(firstPlayer.cards.count) points

                        Second player did not have
                        enough cards to play war
                        """
                        dealEnded(.first)
                        return
                    }
                    
                    firstPlayerCardOnTable = nil
                    secondPlayerCardOnTable = nil
                    
                    warCardCounter = 0
                    gameType = .war
                    warExists()
                }
                else if firstPlayerCard.rank.rawValue > secondPlayerCard.rank.rawValue {
                    print("First player won")
                    firstPlayer.cards += firstPlayerCardsStack
                    firstPlayer.cards += secondPlayerCardsStack
                    
                    resetCards()
                    print("First player cards \(firstPlayer.cards.count)")
                    print("Second player cards \(secondPlayer.cards.count)")
                    if secondPlayer.cards.isEmpty {
                        message = """
                        First player won with \(firstPlayer.cards.count) points

                        Second player run out of cards
                        """
                        playerThatWon = .first
                    }
                    
                    dealEnded(.first)
                }
                else {
                    print("Second player won")
                    secondPlayer.cards += firstPlayerCardsStack
                    secondPlayer.cards += secondPlayerCardsStack
                    
                    resetCards()
                    print("First player cards \(firstPlayer.cards.count)")
                    print("Second player cards \(secondPlayer.cards.count)")
                    
                    if firstPlayer.cards.isEmpty {
                        message = """
                        Second player won with \(secondPlayer.cards.count) points

                        First player run out of cards
                        """
                        playerThatWon = .second
                    }
                    
                    dealEnded(.second)
                }
            }
        case .war:
            warCardCounter += 1
            if warCardCounter == 2 {
                gameType = .normal
                warExists()
            }
        }
        
        
    }
    
}

enum GameType {
    case normal
    case war
}
