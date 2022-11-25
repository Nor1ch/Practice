//
//  ViewController.swift
//  Task_CoreData
//
//  Created by Nor1 on 20.05.2022.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {

    
     var performer : Performer?
    
    private lazy var nameLabel : UILabel = {
        let view = UILabel()
        view.text = "Name:"
        view.textAlignment = .right
        return view
    }()
    private lazy var lastNameLabel : UILabel = {
        let view = UILabel()
        view.text = "Last Name:"
        view.textAlignment = .right
        return view
    }()
    private lazy var birthLabel : UILabel = {
        let view = UILabel()
        view.text = "Birth:"
        view.textAlignment = .right
        return view
    }()
    private lazy var countryLabel : UILabel = {
        let view = UILabel()
        view.text = "Country:"
        view.textAlignment = .right
        return view
    }()
    
    private lazy var nameTextField : UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        return view
    }()
    private lazy var lastNameTextField : UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        return view
    }()
    private lazy var birthTextField : UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.keyboardType = .numberPad
        return view
    }()
    private lazy var countryTextField : UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        return view
    }()
    
    private lazy var stackViewLabels : UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.distribution = .fillEqually
        return view
    }()
    private lazy var stackViewFields : UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstaints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePress))
        if let performer = performer {
            getName().text = performer.name
            getLastName().text = performer.lastName
            getBirth().text = performer.birth
            getCountry().text = performer.country
        }
        
    }
    
    private func setupViews(){
        view.addSubview(stackViewFields)
        view.addSubview(stackViewLabels)
        stackViewLabels.addArrangedSubview(nameLabel)
        stackViewLabels.addArrangedSubview(lastNameLabel)
        stackViewLabels.addArrangedSubview(birthLabel)
        stackViewLabels.addArrangedSubview(countryLabel)
        stackViewFields.addArrangedSubview(nameTextField)
        stackViewFields.addArrangedSubview(lastNameTextField)
        stackViewFields.addArrangedSubview(birthTextField)
        stackViewFields.addArrangedSubview(countryTextField)

    }
    private func makeConstaints(){
       
        
        stackViewLabels.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(4)
            make.right.equalTo(stackViewFields.snp.left).inset(-3)
            
        }
        stackViewFields.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            
            
        }
    }
    
    func getName() -> UITextField{
        return nameTextField
    }
    func getLastName() -> UITextField{
        return lastNameTextField
    }
    func getBirth() -> UITextField{
        return birthTextField
    }
    func getCountry() -> UITextField{
        return countryTextField
    }
    
    @objc private func savePress() {
        performer?.name = getName().text 
        performer?.lastName = getLastName().text
        performer?.birth = getBirth().text
        performer?.country = getCountry().text
        
        try? performer?.managedObjectContext?.save()
        
        navigationController?.popToRootViewController(animated: true)
    }

}

