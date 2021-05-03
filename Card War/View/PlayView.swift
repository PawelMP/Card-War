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
        label.isUserInteractionEnabled = true
        return label
    }()
    
    public var cardViews: [CardPropertiesUI] = []
    
    public var exitButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width/15)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = K.Design.Image.Background
        return image
    }()
    
    let cardAnimations = CardAnimationsManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        manageSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError(K.Error.InitError)
    }
    
    private func manageSubviews() {
        addSubview(backgroundImageView)
        backgroundImageViewConstraints()
        
        addSubview(firstPlayerButton)
        firstPlayerButtonConstraints()
        
        addSubview(secondPlayerButton)
        secondPlayerButtonConstraints()
        
        addSubview(firstPlayerScoreLabel)
        firstPlayerScoreLabelConstraint(for: firstPlayerScoreLabel)
        
        addSubview(secondPlayerScoreLabel)
        secondPlayerScoreLabelConstraint(for: secondPlayerScoreLabel)
        
        addSubview(collectCardsFirstPlayerButton)
        collectCardsButtonConstraints(for: collectCardsFirstPlayerButton)
        
        addSubview(collectCardsSecondPlayerButton)
        collectCardsButtonConstraints(for: collectCardsSecondPlayerButton)
        
        addSubview(collectCardsWhenDrawButton)
        collectCardsButtonConstraints(for: collectCardsWhenDrawButton)
        
        addSubview(exitButton)
        exitButtonConstraints(for: exitButton)
        
        addSubview(descriptionLabel)
        descriptionLabelConstraint(for: descriptionLabel)
        
    }
    
    private func backgroundImageViewConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
    }
    
    private func firstPlayerButtonConstraints() {
        firstPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        firstPlayerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        firstPlayerButton.widthAnchor.constraint(equalToConstant: self.bounds.width/5).isActive = true
        firstPlayerButton.heightAnchor.constraint(equalTo: firstPlayerButton.widthAnchor, multiplier: 1.54).isActive = true
        
        firstPlayerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.bounds.height/10).isActive = true
    }
    
    private func secondPlayerButtonConstraints() {
        secondPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        secondPlayerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        secondPlayerButton.widthAnchor.constraint(equalToConstant: self.bounds.width/5).isActive = true
        secondPlayerButton.heightAnchor.constraint(equalTo: secondPlayerButton.widthAnchor, multiplier: 1.54).isActive = true
        
        secondPlayerButton.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height/10).isActive = true
    }
    
    private func collectCardsButtonConstraints(for button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        button.widthAnchor.constraint(equalTo: firstPlayerButton.widthAnchor, multiplier: 1.5).isActive = true
        button.heightAnchor.constraint(equalTo: firstPlayerButton.heightAnchor, multiplier: 2.1).isActive = true
    }
    
    private func descriptionLabelConstraint(for label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        label.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        label.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
    }
    
    private func firstPlayerScoreLabelConstraint(for label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        let constraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: firstPlayerButton, attribute: .bottom, multiplier: 1, constant: 5)
        constraint.isActive = true
        
    }
    
    private func secondPlayerScoreLabelConstraint(for label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        let constraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: secondPlayerButton, attribute: .top, multiplier: 1, constant: -5)
        constraint.isActive = true
    }
    
    private func exitButtonConstraints(for button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: secondPlayerButton, attribute: .top, multiplier: 1, constant: -5)
        constraint.isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width/15).isActive = true
    }
    
    public func createCardWithAnimation(with card: UIImage?, backImage : UIImage, for player: PlayerNumber, cardType: CardType) {
        cardAnimations.createCardWithAnimation(with: card, backImage: backImage, for: player, cardType: cardType, cardViews: &cardViews, view: self)
    }
    
    public func collectCards(for player: PlayerNumber) {
        for card in cardViews {
            cardAnimations.collectCardAnimation(cardProperties: card, player: player, view: self)
        }
        cardViews.removeAll()
    }
    
    public func collectCardAnimation(cardProperties: CardPropertiesUI, player: PlayerNumber, completion: (() -> Void)?) {
        cardAnimations.collectCardAnimation(cardProperties: cardProperties, player: player, view: self)
    }
    
}

enum CardType {
    case normal, war
}


