//
//  Constants.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 21/03/2021.
//

import Foundation
import UIKit

struct K {
    struct Design {
        struct Color {
            static let BabyBlue = UIColor(red: 0.63, green: 0.78, blue: 1.00, alpha: 1.00)
            static let cgBlack = UIColor.black.cgColor
            static let White = UIColor.white
        }
        struct Image {
            static let Background = UIImage(named: "background")
            static let Logo = UIImage(named: "card_icon")
        }
        struct Font {
            static let PlayButtonFont = UIFont(name: "Marker Felt", size: 25)
            static let GameDescriptionFont = UIFont(name: "Marker Felt", size: UIScreen.main.bounds.height/50)
            static let LogoFont = UIFont(name: "GillSans-UltraBold", size: 80)
        }
        struct PlayButtonProperties {
            static let EdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            static let CornerRadius: CGFloat = 20
            static let BorderWidth: CGFloat = 1
        }
    }
    
    struct Content {
        static let PlayButtonTitleFriend = "Play with friend"
        static let PlayButtonTitleComputer = "Play vs computer"
        static let AppName = "Card War"
    }
    
    struct API {
        static let placeholder = ""
    }
    
    struct Screen {
        static let Frame = UIScreen.main.bounds
        static let Height = Frame.height
        static let Width = Frame.width
    }
    
    struct Error {
        static let InitError = "init(coder:) has not been implemented"
    }
    
}
