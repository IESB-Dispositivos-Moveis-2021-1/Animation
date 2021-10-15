//
//  ViewController.swift
//  BasicAnimation
//
//  Created by Pedro Henrique on 14/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var square: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
            square.isUserInteractionEnabled = true
            square.addGestureRecognizer(tap)
        }
    }
    
    @objc private func onTap(_ sender: UITapGestureRecognizer) {
        print("Chegou um tap")
        
        UIView.transition(with: square,
                          duration: 3,
                          options: [.curveLinear,
                                        .transitionCurlUp,
                                        .allowUserInteraction,
                                        .allowAnimatedContent]) {
            self.square.backgroundColor = UIColor.magenta
        } completion: { (finished) in

        }
        
//        let iesb = UILabel()
//        iesb.text = "IESB"
//        iesb.backgroundColor = UIColor.red
//        iesb.textColor = UIColor.white
//        iesb.font = .boldSystemFont(ofSize: 30)
//        iesb.center = square.center
//        iesb.sizeToFit()
//
//        UIView.transition(from: square,
//                          to: iesb,
//                          duration: 3,
//                          options: [.curveLinear, .transitionFlipFromRight],
//                          completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        
        UIView.animate(withDuration: 5,
                       delay: 1,
                       options: [.curveEaseInOut,
                                    .autoreverse,
                                    .allowUserInteraction,
                                    .allowAnimatedContent]) {
            self.square.center = CGPoint(x: 0, y: 0)
        } completion: { (finished) in
            let point: CGPoint = self.view.center
            print("Centro da tela: \(point)")

            self.square.center = point
            print("Animação terminou")
        }
        
        print("Passou aqui")

    }


}

