//
//  EndVC.swift
//  Card War
//
//  Created by Paweł Pietrzyk on 03/05/2021.
//

import UIKit

class EndVC: UIViewController {
    
    var myView: EndView?
    var results: String?
    
    override func loadView() {
        super.loadView()
        myView = EndView(frame: K.Screen.Frame)
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        myView?.descriptionLabel.text = results
    }
    
    private func setupActions() {
        for button in [myView?.playAgainButton, myView?.menuButton] {
            button?.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
            button?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
    }
    
    @objc func buttonTouched(_ sender: UIButton) {
        sender.alpha = 0.7
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        sender.alpha = 1
        switch sender.tag {
        case 1:
            print("play again")
            self.dismiss(animated: true, completion: nil)
        case 2:
            print("go to menu")
            myView?.window?.rootViewController?.dismiss(animated: true, completion: nil)
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
