//
//  PopTableViewController.swift
//  Task_CoreData
//
//  Created by Nor1 on 24.05.2022.
//

import UIKit


class PopTableViewController : UITableViewController {
    
    private let sortStrings = ["A - Z", "Z - A"]
    var onDoneDo : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 80, height: tableView.contentSize.height)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortStrings.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleString = sortStrings[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = singleString
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0 :
            print(sortStrings[indexPath.row])
            TableViewController.flagForSort = true
            self.onDoneDo!()
            
            
        case 1 :
            print(sortStrings[indexPath.row])
            TableViewController.flagForSort = false
            self.onDoneDo!()
        default:
            break
        }
    }
    
    
}
