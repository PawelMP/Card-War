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
        myView?.firstPlayerButton.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchDown)
        myView?.firstPlayerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView?.secondPlayerButton.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchDown)
        myView?.secondPlayerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonTouched(_ sender: UIButton) {
        //sender.alpha = 0.7
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        //sender.alpha = 1
        switch sender.tag {
        case 1:
            gameViewModel?.firstPlayerPlayCard()
            print("jeden")
            /*if isOpenFirst {
                isOpenFirst = false
                let image = UIImage(named: "blue_back")
                sender.setImage(image, for: .normal)
                self.myView?.layoutIfNeeded()

                UIView.transition(with: myView!.firstPlayerButton, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: {_ in
                    UIView.animate(withDuration: 1, animations: {

                        self.myView?.firstPlayerButtonTopConstraint.isActive = false
                        self.myView?.firstPlayerButtonBottomConstraint.isActive = true
                        self.myView?.layoutIfNeeded()
                    })
                })
            }
            else {
                isOpenFirst = true
                let image = UIImage(named: "9D")
                //sender.setImage(image, for: .normal)
                self.myView?.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.6, animations: {

                    self.myView?.firstPlayerButtonBottomConstraint.isActive = false
                    self.myView?.firstPlayerButtonTopConstraint.isActive = true
                    self.myView?.layoutIfNeeded()
                })
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    sender.setImage(image, for: .normal)
                    UIView.transition(with: self.myView!.firstPlayerButton, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    self.myView?.firstPlayerButton.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
                }
            }*/
        case 2:
            gameViewModel?.secondPlayerPlayCard()
            print("dwa")
            /*if isOpenSecond {
                isOpenSecond = false
                let image = UIImage(named: "red_back")
                sender.setImage(image, for: .normal)
                self.myView?.layoutIfNeeded()
                
                UIView.transition(with: myView!.secondPlayerButton, duration: 3, options: .transitionFlipFromBottom, animations: {
                    self.myView?.layoutIfNeeded()
                    self.myView?.secondPlayerButtonBottomConstraint.isActive = false
                    self.myView?.secondPlayerButtonTopConstraint.isActive = true
                    
                    self.myView?.layoutIfNeeded()
                }, completion: nil)
            }
            else {
                isOpenSecond = true
                let image = UIImage(named: "5C")
                //sender.setImage(image, for: .normal)
                self.myView?.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.6, animations: {

                    self.myView?.secondPlayerButtonTopConstraint.isActive = false
                    self.myView?.secondPlayerButtonBottomConstraint.isActive = true
                    self.myView?.layoutIfNeeded()
                })
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    sender.setImage(image, for: .normal)
                    UIView.transition(with: self.myView!.secondPlayerButton, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                    self.myView?.secondPlayerButton.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
                }
            }*/
        default:
            break
        }
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
    func firstPlayerCard(card: Card) {
        let image = UIImage(named: card.rank.rawValue.description + card.suit.rawValue)

        self.myView?.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6, animations: {

            self.myView?.firstPlayerButtonBottomConstraint.isActive = false
            self.myView?.firstPlayerButtonTopConstraint.isActive = true
            self.myView?.layoutIfNeeded()
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.myView?.firstPlayerButton.setImage(image, for: .normal)
            UIView.transition(with: self.myView!.firstPlayerButton, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            self.myView?.firstPlayerButton.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
        }
    }
    
    func secondPlayerCard(card: Card) {
        let image = UIImage(named: card.rank.rawValue.description + card.suit.rawValue)

        self.myView?.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6, animations: {

            self.myView?.secondPlayerButtonTopConstraint.isActive = false
            self.myView?.secondPlayerButtonBottomConstraint.isActive = true
            self.myView?.layoutIfNeeded()
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.myView?.secondPlayerButton.setImage(image, for: .normal)
            UIView.transition(with: self.myView!.secondPlayerButton, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            self.myView?.secondPlayerButton.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
        }
    }
    
    
}
