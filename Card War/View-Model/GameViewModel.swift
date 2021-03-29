//
//  GameViewModel.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 23/03/2021.
//

import Foundation
import UIKit

protocol GameViewModelDelegate {
    func firstPlayerCard(cardImage: UIImage, backImage: UIImage)
    func secondPlayerCard(cardImage: UIImage, backImage: UIImage)
    func dealDidEnd()
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
            if game.gameType == .normal {
                game.firstPlayerCardOnTable = card
            }
            else if game.gameType == .war {
                game.gameType = .normal
            }
            game.firstPlayerCardsStack.append(card)
            print("Player one pulled \(card.rank) of \(card.suit)")
            if let cardImage = UIImage(named: card.rank.rawValue.description + card.suit.rawValue), let backImage = UIImage(named: card.back.rawValue) {
                delegate?.firstPlayerCard(cardImage: cardImage, backImage: backImage)
            }
        }
        game.checkCards(firstPlayer: firstPlayer, secondPlayer: secondPlayer, dealEnded: {
            delegate?.dealDidEnd()
        })
    }
    
    func secondPlayerPlayCard() {
        if let card = secondPlayer.playCard() {
            if game.gameType == .normal {
                game.secondPlayerCardOnTable = card
            }
            game.secondPlayerCardsStack.append(card)
            print("Player two pulled \(card.rank) of \(card.suit)")
            if let cardImage = UIImage(named: card.rank.rawValue.description + card.suit.rawValue), let backImage = UIImage(named: card.back.rawValue) {
                delegate?.secondPlayerCard(cardImage: cardImage, backImage: backImage)
            }
            
        }
        game.checkCards(firstPlayer: firstPlayer, secondPlayer: secondPlayer, dealEnded: {
            delegate?.dealDidEnd()
        })
    }
    
}
