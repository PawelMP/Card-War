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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        
        gameViewModel = GameViewModel()
        gameViewModel?.delegate = self
        gameViewModel?.updatePlayersScore()
    }
    
    private func setupActions() {
        myView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(descriptionLabelPressed(_:))))
        
        myView?.firstPlayerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView?.secondPlayerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView?.collectCardsFirstPlayerButton.addTarget(self, action: #selector(collectCardsForFirstPlayer(_:)), for: .touchUpInside)
        
        myView?.collectCardsSecondPlayerButton.addTarget(self, action: #selector(collectCardsForSecondPlayer(_:)), for: .touchUpInside)
        
        myView?.collectCardsWhenDrawButton.addTarget(self, action: #selector(collectCardsWhenDraw(_:)), for: .touchUpInside)
    }
    
    @objc func descriptionLabelPressed(_ sender: UITapGestureRecognizer) {
        print("Pressed")
        //sender.isEnabled = false
        //sender.isHidden = false
        myView?.descriptionLabel.isHidden = true
        enablePlayersButtons()
        //sender.text = " LOL"
        //sender.isEnabled = false
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
    

    private func enablePlayersButtons() {
        myView?.firstPlayerButton.isEnabled = true
        myView?.secondPlayerButton.isEnabled = true
    }
    
    private func disableButtons() {
        myView?.firstPlayerButton.isEnabled = false
        myView?.secondPlayerButton.isEnabled = false
        myView?.collectCardsWhenDrawButton.isEnabled = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    func firstPlayerWonGame() {
        print("First player won whole gaaaaame")
        disableButtons()
    }
    
    func secondPlayerWonGame() {
        print("Second player won whole gaaaaame")
        disableButtons()
    }
    
}
