//
//  GameViewModel.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 23/03/2021.
//

import Foundation
import UIKit

protocol GameViewModelDelegate {
    func firstPlayerPlayNormalCard(cardImage: UIImage, backImage: UIImage)
    func secondPlayerPlayNormalCard(cardImage: UIImage, backImage: UIImage)
    func firstPlayerPlayWarCard(backImage: UIImage)
    func secondPlayerPlayWarCard(backImage: UIImage)
    func warExists()
    func dealDidEnd(player: PlayerNumber)
}

class GameViewModel {
    private let firstPlayer = Player(number: 1)
    private let secondPlayer = Player(number: 2)
    private let game = Game()
    
    var delegate: GameViewModelDelegate?
    
    init() {
        game.startGame(players: [firstPlayer, secondPlayer])
    }
    
    func firstPlayerPlayCard() {
        if let card = firstPlayer.playCard() {
            
            if let cardImage = UIImage(named: card.rank.rawValue.description + card.suit.rawValue), let backImage = UIImage(named: card.back.rawValue) {
                switch game.gameType {
                case .normal:
                    //na widoku karta figura do gory
                    delegate?.firstPlayerPlayNormalCard(cardImage: cardImage, backImage: backImage)
                    game.firstPlayerCardOnTable = card
                case .war:
                    //na widoku karta figura do dolu
                    delegate?.firstPlayerPlayWarCard(backImage: backImage)
                }
            }
            
            game.firstPlayerCardsStack.append(card)
            print("Player one pulled \(card.rank) of \(card.suit)")
            /*if let cardImage = UIImage(named: card.rank.rawValue.description + card.suit.rawValue), let backImage = UIImage(named: card.back.rawValue) {
             delegate?.firstPlayerCard(cardImage: cardImage, backImage: backImage)
             }*/
        }
        game.checkCards(firstPlayer: firstPlayer, secondPlayer: secondPlayer,
                        dealEnded: { player in
                            delegate?.dealDidEnd(player: player)
                        },
                        warExists: {
                            delegate?.warExists()
                        })
    }
    
    func secondPlayerPlayCard() {
        if let card = secondPlayer.playCard() {
            
            if let cardImage = UIImage(named: card.rank.rawValue.description + card.suit.rawValue), let backImage = UIImage(named: card.back.rawValue) {
                switch game.gameType {
                case .normal:
                    //na widoku karta figura do gory
                    delegate?.secondPlayerPlayNormalCard(cardImage: cardImage, backImage: backImage)
                    game.secondPlayerCardOnTable = card
                case .war:
                    //na widoku karta figura do dolu
                    delegate?.secondPlayerPlayWarCard(backImage: backImage)
                }
            }
            
            game.secondPlayerCardsStack.append(card)
            print("Player two pulled \(card.rank) of \(card.suit)")
            /*if let cardImage = UIImage(named: card.rank.rawValue.description + card.suit.rawValue), let backImage = UIImage(named: card.back.rawValue) {
             delegate?.secondPlayerCard(cardImage: cardImage, backImage: backImage)
             }*/
            
        }
        game.checkCards(firstPlayer: firstPlayer, secondPlayer: secondPlayer,
                        dealEnded: { player in
                            delegate?.dealDidEnd(player: player)
                        },
                        warExists: {
                            delegate?.warExists()
                        })
    }
    
}
