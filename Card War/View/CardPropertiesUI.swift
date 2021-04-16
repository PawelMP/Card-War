//
//  CardPropertiesUI.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 06/04/2021.
//

import UIKit

struct CardPropertiesUI {
    unowned var imageView: UIImageView
    var bottomConstraint: NSLayoutConstraint
    var topConstraint: NSLayoutConstraint
    var backImage: UIImage
    var cardType: CardType
    var owner: PlayerNumber
}
