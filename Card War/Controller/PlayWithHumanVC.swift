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
        
        myView?.collectCardsButton.addTarget(self, action: #selector(collectCardsButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            gameViewModel?.firstPlayerPlayCard()
        case 2:
            gameViewModel?.secondPlayerPlayCard()
        default:
            break
        }
    }
    
    @objc func collectCardsButtonPressed(_ sender: UIButton) {
        for imageWithConstraints in myView!.cardImages {
            myView?.gatherCardsAnimation(imageView: imageWithConstraints)
            //myView?.collectCardForFirstPlayer(imageView: imageWithConstraints)
            //image.removeFromSuperview()
        }
        
        myView?.cardImages.removeAll()
        print("Collected cards")
        myView?.collectCardsButton.isEnabled = false
        
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
    func dealDidEnd() {
        myView?.collectCardsButton.isEnabled = true
    }
    
    func firstPlayerCard(cardImage: UIImage, backImage: UIImage) {
        //let image = UIImage(named: card.rank.rawValue.description + card.suit.rawValue)

        //myView?.layoutIfNeeded()
        
        myView?.createImageViewAndAnimate(with: cardImage, backImage: backImage, for: 1)
        
        /*UIView.animate(withDuration: 0.6, animations: {

            self.myView?.firstPlayerButtonBottomConstraint.isActive = false
            self.myView?.firstPlayerButtonTopConstraint.isActive = true
            self.myView?.layoutIfNeeded()
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.myView?.firstPlayerButton.setImage(image, for: .normal)
            UIView.transition(with: self.myView!.firstPlayerButton, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            self.myView?.firstPlayerButton.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
        }*/
    }
    
    func secondPlayerCard(cardImage: UIImage, backImage: UIImage) {
        //let image = UIImage(named: card.rank.rawValue.description + card.suit.rawValue)

        myView?.layoutIfNeeded()
        
        myView?.createImageViewAndAnimate(with: cardImage, backImage: backImage, for: 2)
        
        /*UIView.animate(withDuration: 0.6, animations: {

            self.myView?.secondPlayerButtonTopConstraint.isActive = false
            self.myView?.secondPlayerButtonBottomConstraint.isActive = true
            self.myView?.layoutIfNeeded()
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.myView?.secondPlayerButton.setImage(image, for: .normal)
            UIView.transition(with: self.myView!.secondPlayerButton, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            self.myView?.secondPlayerButton.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
        }*/
    }
    
    
}
