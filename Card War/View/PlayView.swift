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
        return button
    }()
    
    public var secondPlayerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "blue_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tag = 2
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
    
    public var cardImages: [(UIImageView, NSLayoutConstraint, NSLayoutConstraint, CardType)] = []
    
    private var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = K.Design.Image.Background
        return image
    }()
    
    public var firstPlayerButtonBottomConstraint: NSLayoutConstraint!
    public var firstPlayerButtonTopConstraint: NSLayoutConstraint!
    
    public var secondPlayerButtonBottomConstraint: NSLayoutConstraint!
    public var secondPlayerButtonTopConstraint: NSLayoutConstraint!
    
    
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
        
        addSubview(collectCardsFirstPlayerButton)
        addCollectCardsButtonConstraints(for: collectCardsFirstPlayerButton)
        
        addSubview(collectCardsSecondPlayerButton)
        addCollectCardsButtonConstraints(for: collectCardsSecondPlayerButton)
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
        
        firstPlayerButtonBottomConstraint = NSLayoutConstraint(item: firstPlayerButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -self.bounds.height/10)
        firstPlayerButtonBottomConstraint.isActive = true
        firstPlayerButtonTopConstraint = NSLayoutConstraint(item: firstPlayerButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: self.bounds.height*0.01)
    }
    
    private func addSecondPlayerButtonConstraints() {
        secondPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        secondPlayerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        secondPlayerButton.widthAnchor.constraint(equalToConstant: self.bounds.width/5).isActive = true
        secondPlayerButton.heightAnchor.constraint(equalTo: secondPlayerButton.widthAnchor, multiplier: 1.54).isActive = true
        
        secondPlayerButtonBottomConstraint = NSLayoutConstraint(item: secondPlayerButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -self.bounds.height*0.01)
        secondPlayerButtonTopConstraint = NSLayoutConstraint(item: secondPlayerButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: self.bounds.height/10)
        
        secondPlayerButtonTopConstraint.isActive = true
    }
    
    func addCollectCardsButtonConstraints(for button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        button.widthAnchor.constraint(equalTo: firstPlayerButton.widthAnchor, multiplier: 1.5).isActive = true
        button.heightAnchor.constraint(equalTo: firstPlayerButton.heightAnchor, multiplier: 2.1).isActive = true
    }
    
    public func createCardWithAnimation(with card: UIImage?, backImage : UIImage, for player: PlayerNumber, cardType: CardType) {
        let imageView = UIImageView()
        imageView.image = backImage
        imageView.contentMode = .scaleAspectFit
        
        self.addSubview(imageView)
        
        var bottomConstraint: NSLayoutConstraint!
        var topConstraint: NSLayoutConstraint!
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: self.frame.width/5).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.54).isActive = true
        
        switch player {
        case .first:
            bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -self.frame.height/10)
            bottomConstraint?.isActive = true
            
            topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: self.bounds.height*0.01)
            
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.6, animations: {
                
                bottomConstraint.isActive = false
                topConstraint.isActive = true
                self.layoutIfNeeded()
            })
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                switch cardType {
                case .normal:
                    if let cardImage = card {
                        imageView.image = cardImage
                        UIView.transition(with: imageView, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    }
                    
                case .war:
                    break
                }
                imageView.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
            }
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
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                switch cardType {
                case .normal:
                    if let cardImage = card {
                        imageView.image = cardImage
                        UIView.transition(with: imageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                    }
                case .war :
                    break
                }
                imageView.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
                
            }
        case .nobody:
            break
        }
        
        cardImages.append((imageView, bottomConstraint, topConstraint, cardType))
    }
    
    public func collectCardsAnimation(imageView: (UIImageView, NSLayoutConstraint, NSLayoutConstraint, CardType), player: PlayerNumber, completion: (() -> Void)?) {
        var centerConstraint: NSLayoutConstraint!
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, animations: {
            
            imageView.1.isActive = false
            imageView.2.isActive = false
            
            centerConstraint = NSLayoutConstraint(item: imageView.0, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            centerConstraint.isActive = true
            imageView.0.transform = CGAffineTransform.identity
            
            switch imageView.3 {
            case .normal:
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    self.layoutIfNeeded()
                    imageView.0.image = UIImage(named: "blue_back") //!!!!!!!
                    UIView.transition(with: imageView.0, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                }
            case .war:
                break
            }
            
            self.layoutIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                UIView.animate(withDuration: 1, animations: {
                    centerConstraint.isActive = false
                    switch player {
                    case .first:
                        imageView.0.bottomAnchor.constraint(equalTo: self.firstPlayerButton.bottomAnchor).isActive = true
                    case .second:
                        imageView.0.topAnchor.constraint(equalTo: self.secondPlayerButton.topAnchor).isActive = true
                    case .nobody:
                        break
                    }
                    //imageView.0.bottomAnchor.constraint(equalTo: self.firstPlayerButton.bottomAnchor).isActive = true
                    self.layoutIfNeeded()
                    //imageView.0.removeFromSuperview()
                })
            })
        })
        
    }
    
}

enum CardType {
    case normal, war
}
