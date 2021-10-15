//
//  ViewController.swift
//  BongoBongo
//
//  Created by Pedro Henrique on 14/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var board: UIView! {
        didSet {
            animator = UIDynamicAnimator(referenceView: board)
            behavior = SquareBehavior()
            animator?.addBehavior(behavior!)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTapSquare(_:)))
            board.isUserInteractionEnabled = true
            board.addGestureRecognizer(tap)
            
        }
    }
    
    
    private var animator: UIDynamicAnimator?
    private var behavior: SquareBehavior?
    private var squares = [UIView]()
    
    private let squareSize = CGSize(width: 30, height: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc private func onTapSquare(_ sender: UITapGestureRecognizer) {
        createSquare(at: sender.location(in: board))
    }

    @IBAction func onSquare(_ sender: UIButton) {
        let x = arc4random() % UInt32(board.bounds.size.width)
        createSquare(at: CGPoint(x: CGFloat(x), y: 0))
    }
    
    private func createSquare(at point: CGPoint) {
        let frame = CGRect(origin: point, size: squareSize)
        let square = UIView(frame: frame)
        square.backgroundColor = randomColor()
        board.addSubview(square)
        squares.append(square)
        behavior?.addItem(square)
    }
    
    @IBAction func onExplode(_ sender: UIButton) {
        guard squares.count > 0 else { return }
        
        squares.forEach({behavior?.removeItem($0)})
        
        UIView.animate(withDuration: 1) {
            self.explodeSquares()
        } completion: { (finished) in
            self.squares.forEach({$0.removeFromSuperview()})
            self.squares.removeAll()
        }
        
    }
    
    private func explodeSquares() {
        for sq in self.squares {
            let x = arc4random() % UInt32(self.board.bounds.size.width)
            let y = self.board.bounds.size.height
            sq.center = CGPoint(x: CGFloat(x), y: -y)
        }
    }
    
    private func randomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...1),
                       green: CGFloat.random(in: 0...1),
                       blue: CGFloat.random(in: 0...1),
                       alpha: 1)
    }
}

