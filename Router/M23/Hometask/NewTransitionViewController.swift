//
//  NewTransitionViewController.swift
//  M23
//
//  Created by Nor1 on 17.06.2022.
//

import UIKit

class NewTransitionViewController : UIViewController {
    
    private let viewModel : NewTransitionViewModel
    
    init(viewModel: NewTransitionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        let button = UIButton(title: "New Transition", target: self, selector: #selector(onButtonPressed))
        view.addSubview(button)
        makeConstraints(button: button)
        
    }
    
    @objc private func onButtonPressed(){
        print("tap")
        viewModel.tapped()
    }
    private func makeConstraints(button: UIButton){
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
