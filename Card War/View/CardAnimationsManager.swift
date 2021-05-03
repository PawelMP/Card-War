//
//  CardAnimationsManager.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 03/05/2021.
//

import Foundation
import UIKit

struct CardAnimationsManager {
    
    //static let shared = CardAnimationsManager()
    //private init() {
        
    //}
    
    private func createCardImageView(with image: UIImage, in view: PlayView) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width/5).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.54).isActive = true
        return imageView
    }
    
    private func flipCardAnimationWithRotation(imageView: UIImageView, to image: UIImage?, cardType: CardType, options: UIView.AnimationOptions, rotation: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            switch cardType {
            case .normal:
                if let cardImage = image {
                    imageView.image = cardImage
                    UIView.transition(with: imageView, duration: 0.3, options: options, animations: {
                        if rotation {
                            imageView.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
                        }
                    }, completion: nil)
                }
            case .war:
                UIView.transition(with: imageView, duration: 0.3, options: .curveLinear, animations: {
                    if rotation {
                        imageView.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
                    }
                }, completion: nil)
            }
        }
    }
    
    public func createCardWithAnimation(with card: UIImage?, backImage : UIImage, for player: PlayerNumber, cardType: CardType, cardViews: inout [CardPropertiesUI], view: PlayView) {
        let imageView = createCardImageView(with: backImage, in: view)
        var bottomConstraint: NSLayoutConstraint!
        var topConstraint: NSLayoutConstraint!
        var owner: PlayerNumber!
        
        switch player {
        case .first:
            bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -view.frame.height/10)
            bottomConstraint.isActive = true
            
            topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: view.bounds.height*0.01)
            
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.6, animations: {
                
                bottomConstraint.isActive = false
                topConstraint.isActive = true
                view.layoutIfNeeded()
            })
            
            flipCardAnimationWithRotation(imageView: imageView, to: card, cardType: cardType, options: .transitionFlipFromRight, rotation: true)
            owner = PlayerNumber.first
        case .second:
            bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -view.bounds.height*0.01)
            
            topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.bounds.height/10)
            topConstraint.isActive = true
            
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.6, animations: {
                
                topConstraint.isActive = false
                bottomConstraint.isActive = true
                view.layoutIfNeeded()
            })
            flipCardAnimationWithRotation(imageView: imageView, to: card, cardType: cardType, options: .transitionFlipFromLeft, rotation: true)
            owner = PlayerNumber.second
        case .nobody:
            break
        }
        cardViews.append(CardPropertiesUI(imageView: imageView, bottomConstraint: bottomConstraint, topConstraint: topConstraint, backImage: backImage, cardType: cardType, owner: owner))
    }
    
    public func collectCardAnimation(cardProperties: CardPropertiesUI, player: PlayerNumber, view: PlayView) {
        var centerConstraint: NSLayoutConstraint!
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, animations: {

            if player != .nobody {
                cardProperties.bottomConstraint.isActive = false
                cardProperties.topConstraint.isActive = false
                centerConstraint = NSLayoutConstraint(item: cardProperties.imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
                centerConstraint.isActive = true
            }
            cardProperties.imageView.transform = CGAffineTransform.identity
            
            self.flipCardAnimationWithRotation(imageView: cardProperties.imageView, to: cardProperties.backImage, cardType: cardProperties.cardType, options: .transitionFlipFromLeft, rotation: false)
            
            view.layoutIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                UIView.animate(withDuration: 1, animations: {
                    switch player {
                    case .first:
                        centerConstraint.isActive = false
                        cardProperties.imageView.bottomAnchor.constraint(equalTo: view.firstPlayerButton.bottomAnchor).isActive = true
                    case .second:
                        centerConstraint.isActive = false
                        cardProperties.imageView.topAnchor.constraint(equalTo: view.secondPlayerButton.topAnchor).isActive = true
                    case .nobody:
                        cardProperties.bottomConstraint.isActive = false
                        cardProperties.topConstraint.isActive = false
                        switch cardProperties.owner {
                        case .first:
                            cardProperties.imageView.bottomAnchor.constraint(equalTo: view.firstPlayerButton.bottomAnchor).isActive = true
                        case .second:
                            cardProperties.imageView.topAnchor.constraint(equalTo: view.secondPlayerButton.topAnchor).isActive = true
                        case .nobody:
                            break
                        }
                    }
                    view.layoutIfNeeded()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                        cardProperties.imageView.removeFromSuperview()
                    })
                })
            })
        })
        
    }
}
