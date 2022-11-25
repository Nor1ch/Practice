//
//  Fish.swift
//  M21_Homework
//
//  Created by Nor1 on 29.05.2022.
//

import UIKit

class Fish : UIImageView {
    static var count : Int = 0
    var isFishCatched : Bool = false

    lazy var fishImageView : UIImageView = {
       let image = UIImage(named: "fish")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 130, height: 130)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func move(uiv: UIView){
        let ran = Int.random(in: 1...4)
        switch ran {
        case 1 :
            moveLeft(uiv: uiv)
        case 2 :
            moveTop(uiv: uiv)
        case 3 :
            moveRight(uiv: uiv)
        case 4 :
            moveBottom(uiv: uiv)
        default:
            break
        }
    }
    func fishCatchedAnimation() {
        
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.fishImageView.transform = CGAffineTransform(scaleX: -2, y: -2)
            self.fishImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2)
            self.fishImageView.alpha = -1
        })
        Fish.count += 1
    }
    
    
    private func moveLeft(uiv: UIView) {
      if isFishCatched { return }
      
      UIView.animate(withDuration: 1.5,
                     delay: 0,
                     options: [.curveEaseInOut , .allowUserInteraction],
                     animations: {
          self.fishImageView.center = CGPoint(x: uiv.bounds.minX + CGFloat(Int.random(in: 80...150)), y: uiv.bounds.midY + CGFloat(Int.random(in: -100...100)))
          
      },
                     completion: { finished in
                      self.move(uiv: uiv)
      })
    }
    

    private func moveRight(uiv: UIView) {
        if isFishCatched { return }
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                       self.fishImageView.center = CGPoint(x: uiv.bounds.maxX - CGFloat(Int.random(in: 80...150)), y: uiv.bounds.midY + CGFloat(Int.random(in: -100...100)))
        },
                       completion: {_ in
                       self.move(uiv: uiv)
        })
    }

   private func moveTop(uiv: UIView) {
        if isFishCatched { return }
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                       self.fishImageView.center = CGPoint(x: uiv.bounds.midX + CGFloat(Int.random(in: -100...100)) , y: uiv.bounds.minY + CGFloat(Int.random(in: 120...200)))
        },
                       completion: {_ in
                       self.move(uiv: uiv)
        })
    }

    private func moveBottom(uiv: UIView) {
        if isFishCatched { return }
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                       self.fishImageView.center = CGPoint(x: uiv.bounds.midX + CGFloat(Int.random(in: -100...100)), y: uiv.bounds.maxY - CGFloat(Int.random(in: 120...200)))
        },
                       completion: {_ in
                       self.move(uiv: uiv)
        })
    }
}
