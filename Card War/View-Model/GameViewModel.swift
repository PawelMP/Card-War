//
//  GameViewModel.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 23/03/2021.
//

import Foundation

protocol GameViewModelDelegate {
    func firstPlayerCard(card: Card)
    func secondPlayerCard(card: Card)
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
            game.firstPlayerCardOnTable = card
            game.firstPlayerCardsStack.append(card)
            delegate?.firstPlayerCard(card: card)
        }
        game.checkCards()
    }
    
    func secondPlayerPlayCard() {
        if let card = secondPlayer.playCard() {
            game.secondPlayerCardOnTable = card
            game.secondPlayerCardsStack.append(card)
            delegate?.secondPlayerCard(card: card)
        }
        game.checkCards()
    }
    
}
