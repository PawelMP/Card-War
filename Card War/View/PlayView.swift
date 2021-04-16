//
//  PlayView.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 21/03/2021.
//

import UIKit

class PlayView: UIView {
    
    public var firstPlayerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "blue_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tag = 1
        button.isEnabled = false
        return button
    }()
    
    public var firstPlayerScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: First"
        label.textColor = .white
        label.font = K.Design.Font.GameDescriptionFont
        return label
    }()
    
    public var secondPlayerScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: Second"
        label.textColor = .white
        label.font = K.Design.Font.GameDescriptionFont
        label.transform = CGAffineTransform(rotationAngle: .pi)
        return label
    }()
    
    public var secondPlayerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "blue_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tag = 2
        button.isEnabled = false
        return button
    }()
    
    public var collectCardsFirstPlayerButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        return button
    }()
    
    public var collectCardsSecondPlayerButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        return button
    }()
    
    public var collectCardsWhenDrawButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        return button
    }()
    
    public var descriptionLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0.5
        label.textColor = .white
        label.font = K.Design.Font.GameDescriptionFont
        label.textAlignment = .center
        label.text = """
                There will be some awesome game description.
                Click anywhere to start
                """
        label.backgroundColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        label.numberOfLines = 0
        return label
    }()
    
    public var cardViews: [CardPropertiesUI] = []
    
    private var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = K.Design.Image.Background
        //image.contentMode = .scaleToFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        manageSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError(K.Error.InitError)
    }
    
    private func manageSubviews() {
        addSubview(backgroundImageView)
        addBackgroundImageViewConstraints()
        
        addSubview(firstPlayerButton)
        addFirstPlayerButtonConstraints()
        
        addSubview(secondPlayerButton)
        addSecondPlayerButtonConstraints()
        
        addSubview(firstPlayerScoreLabel)
        addFirstPlayerScoreLabelConstraint(for: firstPlayerScoreLabel)
        
        addSubview(secondPlayerScoreLabel)
        addSecondPlayerScoreLabelConstraint(for: secondPlayerScoreLabel)
        
        addSubview(collectCardsFirstPlayerButton)
        addCollectCardsButtonConstraints(for: collectCardsFirstPlayerButton)
        
        addSubview(collectCardsSecondPlayerButton)
        addCollectCardsButtonConstraints(for: collectCardsSecondPlayerButton)
        
        addSubview(collectCardsWhenDrawButton)
        addCollectCardsButtonConstraints(for: collectCardsWhenDrawButton)
        
        addSubview(descriptionLabel)
        addDescriptionLabelConstraint(for: descriptionLabel)
        
    }
    
    private func addBackgroundImageViewConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
    }
    
    private func addFirstPlayerButtonConstraints() {
        firstPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        firstPlayerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        firstPlayerButton.widthAnchor.constraint(equalToConstant: self.bounds.width/5).isActive = true
        firstPlayerButton.heightAnchor.constraint(equalTo: firstPlayerButton.widthAnchor, multiplier: 1.54).isActive = true
        
        firstPlayerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.bounds.height/10).isActive = true
    }
    
    private func addSecondPlayerButtonConstraints() {
        secondPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        secondPlayerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        secondPlayerButton.widthAnchor.constraint(equalToConstant: self.bounds.width/5).isActive = true
        secondPlayerButton.heightAnchor.constraint(equalTo: secondPlayerButton.widthAnchor, multiplier: 1.54).isActive = true
        
        secondPlayerButton.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height/10).isActive = true
    }
    
    func addCollectCardsButtonConstraints(for button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        button.widthAnchor.constraint(equalTo: firstPlayerButton.widthAnchor, multiplier: 1.5).isActive = true
        button.heightAnchor.constraint(equalTo: firstPlayerButton.heightAnchor, multiplier: 2.1).isActive = true
    }
    
    private func addDescriptionLabelConstraint(for label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        label.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        label.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
    }
    
    private func addFirstPlayerScoreLabelConstraint(for label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        var constraint: NSLayoutConstraint
        constraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: firstPlayerButton, attribute: .bottom, multiplier: 1, constant: 5)
        constraint.isActive = true
        
    }
    
    private func addSecondPlayerScoreLabelConstraint(for label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        var constraint: NSLayoutConstraint
        constraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: secondPlayerButton, attribute: .top, multiplier: 1, constant: -5)
        constraint.isActive = true
    }
    
    private func createCardImageView(with image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: self.frame.width/5).isActive = true
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
    
    public func createCardWithAnimation(with card: UIImage?, backImage : UIImage, for player: PlayerNumber, cardType: CardType) {
        let imageView = createCardImageView(with: backImage)
        var bottomConstraint: NSLayoutConstraint!
        var topConstraint: NSLayoutConstraint!
        var owner: PlayerNumber!
        
        switch player {
        case .first:
            bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -self.frame.height/10)
            bottomConstraint.isActive = true
            
            topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: self.bounds.height*0.01)
            
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.6, animations: {
                
                bottomConstraint.isActive = false
                topConstraint.isActive = true
                self.layoutIfNeeded()
            })
            
            flipCardAnimationWithRotation(imageView: imageView, to: card, cardType: cardType, options: .transitionFlipFromRight, rotation: true)
            owner = PlayerNumber.first
        case .second:
            bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -self.bounds.height*0.01)
            
            topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: self.bounds.height/10)
            topConstraint.isActive = true
            
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.6, animations: {
                
                topConstraint.isActive = false
                bottomConstraint.isActive = true
                self.layoutIfNeeded()
            })
            flipCardAnimationWithRotation(imageView: imageView, to: card, cardType: cardType, options: .transitionFlipFromLeft, rotation: true)
            owner = PlayerNumber.second
        case .nobody:
            break
        }
        cardViews.append(CardPropertiesUI(imageView: imageView, bottomConstraint: bottomConstraint, topConstraint: topConstraint, backImage: backImage, cardType: cardType, owner: owner))
    }
    
    public func collectCards(for player: PlayerNumber) {
        for card in cardViews {
            collectCardAnimation(cardProperties: card, player: player, completion: nil)
        }
        cardViews.removeAll()
    }
    
    public func collectCardAnimation(cardProperties: CardPropertiesUI, player: PlayerNumber, completion: (() -> Void)?) {
        var centerConstraint: NSLayoutConstraint!
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, animations: {

            if player != .nobody {
                cardProperties.bottomConstraint.isActive = false
                cardProperties.topConstraint.isActive = false
                centerConstraint = NSLayoutConstraint(item: cardProperties.imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
                centerConstraint.isActive = true
            }
            cardProperties.imageView.transform = CGAffineTransform.identity
            
            self.flipCardAnimationWithRotation(imageView: cardProperties.imageView, to: cardProperties.backImage, cardType: cardProperties.cardType, options: .transitionFlipFromLeft, rotation: false)
            
            self.layoutIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                UIView.animate(withDuration: 1, animations: {
                    switch player {
                    case .first:
                        centerConstraint.isActive = false
                        cardProperties.imageView.bottomAnchor.constraint(equalTo: self.firstPlayerButton.bottomAnchor).isActive = true
                    case .second:
                        centerConstraint.isActive = false
                        cardProperties.imageView.topAnchor.constraint(equalTo: self.secondPlayerButton.topAnchor).isActive = true
                    case .nobody:
                        cardProperties.bottomConstraint.isActive = false
                        cardProperties.topConstraint.isActive = false
                        switch cardProperties.owner {
                        case .first:
                            cardProperties.imageView.bottomAnchor.constraint(equalTo: self.firstPlayerButton.bottomAnchor).isActive = true
                        case .second:
                            cardProperties.imageView.topAnchor.constraint(equalTo: self.secondPlayerButton.topAnchor).isActive = true
                        case .nobody:
                            break
                        }
                    }
                    self.layoutIfNeeded()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                        cardProperties.imageView.removeFromSuperview()
                    })
                })
            })
        })
        
    }
    
}

enum CardType {
    case normal, war
}


