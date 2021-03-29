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
    
    public var collectCardsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.isEnabled = false
        return button
    }()
    
    public var cardImages: [(UIImageView,NSLayoutConstraint,NSLayoutConstraint)] = []
    
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
        
        addSubview(collectCardsButton)
        addCollectCardsButtonConstraints()
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
    
    func addCollectCardsButtonConstraints() {
        collectCardsButton.translatesAutoresizingMaskIntoConstraints = false
        collectCardsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectCardsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        collectCardsButton.widthAnchor.constraint(equalTo: firstPlayerButton.widthAnchor, multiplier: 1.5).isActive = true
        collectCardsButton.heightAnchor.constraint(equalTo: firstPlayerButton.heightAnchor, multiplier: 2.1).isActive = true
    }
    
    public func createImageViewAndAnimate(with card: UIImage, backImage : UIImage, for player: Int) {
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
        case 1:
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
                imageView.image = card
                UIView.transition(with: imageView, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                imageView.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
            }
        case 2:
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
                imageView.image = card
                UIView.transition(with: imageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                imageView.transform = CGAffineTransform(rotationAngle: (CGFloat(Int.random(in: -20...20)) * .pi) / 180.0)
                
            }
        default:
            break
        }
        
        cardImages.append((imageView,bottomConstraint,topConstraint))
    }
    
    public func collectCardForFirstPlayer(imageView: (UIImageView,NSLayoutConstraint,NSLayoutConstraint)) {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, animations: {
            
            imageView.1.isActive = true
            self.layoutIfNeeded()
        })
    }
    
    public func gatherCardsAnimation(imageView: (UIImageView,NSLayoutConstraint,NSLayoutConstraint)) {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, animations: {
            
            imageView.1.isActive = false
            imageView.2.isActive = false
            //imageView.0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            imageView.0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.6, animations: {
                
                imageView.1.isActive = false
                //imageView.0.bottomAnchor.constraint(equalTo: self.firstPlayerButton.bottomAnchor).isActive = true
            })
        })
        
    }
    
}
