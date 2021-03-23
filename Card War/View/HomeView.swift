//
//  HomeView.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 19/03/2021.
//

import UIKit

class HomeView: UIView {
    
    public var playWithHumanButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = K.Design.Color.BabyBlue
        button.setTitle(K.Content.PlayButtonTitleFriend, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = K.Design.Font.PlayButtonFont
        button.contentEdgeInsets = K.Design.PlayButtonProperties.EdgeInsets
        button.layer.cornerRadius = K.Design.PlayButtonProperties.CornerRadius
        button.layer.borderWidth = K.Design.PlayButtonProperties.BorderWidth
        button.layer.borderColor = K.Design.Color.cgBlack
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 1
        return button
    }()
    
    public var playWithComputerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = K.Design.Color.BabyBlue
        button.setTitle(K.Content.PlayButtonTitleComputer, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = K.Design.Font.PlayButtonFont
        button.contentEdgeInsets = K.Design.PlayButtonProperties.EdgeInsets
        button.layer.cornerRadius = K.Design.PlayButtonProperties.CornerRadius
        button.layer.borderWidth = K.Design.PlayButtonProperties.BorderWidth
        button.layer.borderColor = K.Design.Color.cgBlack
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 2
        return button
    }()
    
    private var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = K.Design.Image.Background
        return image
    }()
    
    private var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = K.Design.Image.Logo
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = K.Content.AppName
        label.font = K.Design.Font.LogoFont
        label.textColor = K.Design.Color.White
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var buttonsStackView: UIStackView!
    
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
        
        addSubview(logoImageView)
        addLogoImageViewConstraints()
        
        addSubview(nameLabel)
        addNameLabelConstraints()
        
        addSubview(playWithHumanButton)
        addSubview(playWithComputerButton)
        
        buttonsStackView = setupButtonsStackView()
        addSubview(buttonsStackView)
        addButtonStackViewConstraints()

    }
    
    private func addBackgroundImageViewConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
    }
    
    private func addLogoImageViewConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height/10).isActive = true
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.widthAnchor.constraint(equalToConstant: self.bounds.width/3).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor).isActive = true
    }
    
    private func addNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant:0).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width-100).isActive = true
    }
    
    private func setupButtonsStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [playWithHumanButton,playWithComputerButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }
    
    private func addButtonStackViewConstraints() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.widthAnchor.constraint(equalToConstant: self.bounds.width-80).isActive = true
        buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100).isActive = true
    }
    
}
