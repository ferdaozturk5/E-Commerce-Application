//
//  ViewController.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 31.01.2021.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    let animation = Animation.named("loader")
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.frame = CGRect(x: 79, y: 530, width: 300, height: 300)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "loginRegister", sender: nil)
    }
        
    }
    
}
