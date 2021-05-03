//
//  PlayWithHumanVC.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 20/03/2021.
//

import UIKit

class PlayWithHumanVC: UIViewController {
    
    var myView: PlayView?
    
    var isOpenFirst = false
    var isOpenSecond = false
    
    var gameViewModel: GameViewModel?
    
    override func loadView() {
        myView = PlayView(frame: K.Screen.Frame)
        view = myView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupActions()
        
        gameViewModel = GameViewModel()
        gameViewModel?.delegate = self
        gameViewModel?.updatePlayersScore()
        
        enablePlayersButtons()
    }
    
    private func setupActions() {
        myView?.descriptionLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(descriptionLabelPressed(_:))))
        
        myView?.firstPlayerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView?.secondPlayerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView?.collectCardsFirstPlayerButton.addTarget(self, action: #selector(collectCardsForFirstPlayer(_:)), for: .touchUpInside)
        
        myView?.collectCardsSecondPlayerButton.addTarget(self, action: #selector(collectCardsForSecondPlayer(_:)), for: .touchUpInside)
        
        myView?.collectCardsWhenDrawButton.addTarget(self, action: #selector(collectCardsWhenDraw(_:)), for: .touchUpInside)
        
        myView?.exitButton.addTarget(self, action: #selector(exitToHome(_ :)), for: .touchUpInside)
        myView?.exitButton.addTarget(self, action: #selector(exitToHomeTouched(_ :)), for: .touchDown)

    }
    
    @objc func descriptionLabelPressed(_ sender: UITapGestureRecognizer) {
        myView?.descriptionLabel.removeFromSuperview()
        enablePlayersButtons()
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        switch sender.tag {
        case 1:
            gameViewModel?.firstPlayerPlayCard()
        case 2:
            gameViewModel?.secondPlayerPlayCard()
        default:
            break
        }
    }
    
    @objc func collectCardsForFirstPlayer(_ sender: UIButton) {
        myView?.collectCards(for: .first)
        
        sender.isEnabled = false
        enablePlayersButtons()
        
        gameViewModel?.updatePlayersScore()
        gameViewModel?.checkIfGameNeedsToEnd()
    }
    
    @objc func collectCardsForSecondPlayer(_ sender: UIButton) {
        myView?.collectCards(for: .second)
        
        sender.isEnabled = false
        enablePlayersButtons()
        gameViewModel?.updatePlayersScore()
        gameViewModel?.checkIfGameNeedsToEnd()
    }
    
    @objc func collectCardsWhenDraw(_ sender: UIButton) {
        myView?.collectCards(for: .nobody)
        
        sender.isEnabled = false
        enablePlayersButtons()
        self.gameViewModel?.updatePlayersScore()
    }
    
    @objc func exitToHome(_ sender: UIButton) {
        sender.alpha = 1
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func exitToHomeTouched(_ sender: UIButton) {
        sender.alpha = 0.7
    }
    

    private func enablePlayersButtons() {
        myView?.firstPlayerButton.isEnabled = true
        myView?.secondPlayerButton.isEnabled = true
    }
    
    private func disableButtons() {
        myView?.firstPlayerButton.isEnabled = false
        myView?.secondPlayerButton.isEnabled = false
        myView?.collectCardsWhenDrawButton.isEnabled = false
    }
    
    func presentEndVC(with message: String, viewController: EndVC) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2 , execute: {
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            viewController.results = message
            self.present(viewController, animated: true, completion: nil)
        })
    }

}

extension PlayWithHumanVC: GameViewModelDelegate {
    
    func updatePlayersScore(first: Int, second: Int) {
        myView?.firstPlayerScoreLabel.text = "Score: " + first.description
        myView?.secondPlayerScoreLabel.text = "Score: " + second.description
    }
    
    func firstPlayerPlayNormalCard(cardImage: UIImage, backImage: UIImage) {
        myView?.createCardWithAnimation(with: cardImage, backImage: backImage, for: .first, cardType: .normal)
    }
    
    func secondPlayerPlayNormalCard(cardImage: UIImage, backImage: UIImage) {
        myView?.createCardWithAnimation(with: cardImage, backImage: backImage, for: .second, cardType: .normal)
    }
    
    func firstPlayerPlayWarCard(backImage: UIImage) {
        myView?.createCardWithAnimation(with: nil, backImage: backImage, for: .first, cardType: .war)
    }
    
    func secondPlayerPlayWarCard(backImage: UIImage) {
        myView?.createCardWithAnimation(with: nil, backImage: backImage, for: .second, cardType: .war)
    }
    
    func dealDidEnd(player: PlayerNumber) {
        switch player {
        case .first:
            myView?.collectCardsFirstPlayerButton.isEnabled = true
        case .second:
            myView?.collectCardsSecondPlayerButton.isEnabled = true
        case .nobody:
            myView?.collectCardsWhenDrawButton.isEnabled = true
        }
    }
    
    func warExists() {
        enablePlayersButtons()
    }
    
    func firstPlayerWonGame(message: String) {
        presentEndVC(with: message, viewController: EndVC())
        disableButtons()
    }
    
    func secondPlayerWonGame(message: String) {
        presentEndVC(with: message, viewController: EndVC())
        disableButtons()
    }
    
}
