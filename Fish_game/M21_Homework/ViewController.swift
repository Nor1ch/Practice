//
//  ViewController.swift
//  M21_Homework
//
//  Created by Maxim Nikolaev on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var fish = Fish()
    var ocean : [Fish] = [Fish(),Fish(),Fish(),Fish(),Fish()]
    

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        countLabel.text = String(Fish.count)
        ocean.forEach {
            view.addSubview($0.fishImageView)
            $0.fishImageView.center = view.center
            $0.move(uiv: view)
        }
        addButton.setTitle("ADD", for: .normal)
        addButton.isEnabled = false
       
        
    }
        
    @IBAction func addPressed(_ sender: Any) {
        ocean.removeAll()
        for _ in 1...5 {
            ocean.append(Fish())
        }
        ocean.forEach {
            view.addSubview($0.fishImageView)
            $0.fishImageView.center = view.center
            $0.move(uiv: view)
        }
        view.layoutIfNeeded()
        addButton.isEnabled = false
        
    }
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
            let tapLocation = gesture.location(in: view)
            ocean.forEach{
            if ($0.fishImageView.layer.presentation()?.frame.contains(tapLocation))! {
                if $0.isFishCatched { return }
                $0.isFishCatched = true
                $0.fishCatchedAnimation()
                countLabel.text = String(Fish.count)
                if Fish.count % 5 == 0 {
                    addButton.isEnabled = true
                }
            }
        }
    }
}

