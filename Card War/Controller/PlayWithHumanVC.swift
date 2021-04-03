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
    }
    
    private func setupActions() {
        myView?.firstPlayerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView?.secondPlayerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView?.collectCardsFirstPlayerButton.addTarget(self, action: #selector(collectCardsForFirstPlayer(_:)), for: .touchUpInside)
        
        myView?.collectCardsSecondPlayerButton.addTarget(self, action: #selector(collectCardsForSecondPlayer(_:)), for: .touchUpInside)
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
        for imageWithConstraints in myView!.cardImages {
            myView?.collectCardsAnimation(imageView: imageWithConstraints, player: .first, completion: nil)
        }
        
        myView?.cardImages.removeAll()
        print("Collected cards")
        sender.isEnabled = false
        
        enablePlayersButtons()
    }
    
    @objc func collectCardsForSecondPlayer(_ sender: UIButton) {
        for imageWithConstraints in myView!.cardImages {
            myView?.collectCardsAnimation(imageView: imageWithConstraints, player: .second, completion: nil)
        }
        
        myView?.cardImages.removeAll()
        print("Collected cards")
        sender.isEnabled = false
        
        enablePlayersButtons()
    }
    

    private func enablePlayersButtons() {
        myView?.firstPlayerButton.isEnabled = true
        myView?.secondPlayerButton.isEnabled = true
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
            break
        }
    }
    
    func warExists() {
        enablePlayersButtons()
    }
    
}
