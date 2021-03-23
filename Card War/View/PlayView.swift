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
        button.setImage(UIImage(named: "red_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tag = 2
        return button
    }()
    
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
    
}
