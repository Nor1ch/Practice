//
//  TableViewController.swift
//  Task_CoreData
//
//  Created by Nor1 on 20.05.2022.
//

import UIKit
import CoreData

class TableViewController : UITableViewController {
    
   
       
      
    
    static var flagForSort : Bool?
    
    
    private let keyForStand = "Key"
    
    private let persistentContainer = NSPersistentContainer(name: "ModelPerformer")
    private var sortD : NSSortDescriptor {
        if TableViewController.flagForSort! {
        return NSSortDescriptor(key: "name", ascending: true)}
        else {
        return NSSortDescriptor(key: "name", ascending: false)
        }
    }
    
    private lazy var fetchedResultsController : NSFetchedResultsController<Performer> = {
        let fetchRequest = Performer.fetchRequest()
        fetchRequest.sortDescriptors = [sortD]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewController.flagForSort = UserDefaults.standard.bool(forKey: keyForStand)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerformer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(doSort))
        
        persistentContainer.loadPersistentStores { (presistentStoreDescription, error) in
            if let error = error {
                print("ERROR DOWNLOAD")
                print(error.localizedDescription)
            } else {
                do {
                    try self.fetchedResultsController.performFetch()
                } catch  {
                    print(error)
                }
            }
        }
    }
    
    @objc private func doSort(){
        guard let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popTableViewController") as? PopTableViewController else { return }
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.tableView
        popOverVC?.sourceRect = CGRect(x: (self.navigationController?.navigationBar.bounds.minX)!, y: (self.navigationController?.navigationBar.bounds.minY)!, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 80, height: 250)
        self.present(popVC, animated: true, completion: nil)
        popVC.onDoneDo = {
            popVC.dismiss(animated: true, completion: self.complitionSort)
        }
        
    }
    
     func complitionSort() {

             fetchedResultsController.fetchRequest.sortDescriptors = [sortD]
         do {
             try fetchedResultsController.performFetch()
         } catch  {
             print("podumay eshe raz")
         }
             self.tableView.reloadData()
             UserDefaults.standard.set(TableViewController.flagForSort, forKey: keyForStand)
         }
     
   
    @objc private func addNewPerformer(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.performer = Performer.init(entity: NSEntityDescription.entity(forEntityName: "Performer", in: persistentContainer.viewContext)!, insertInto: persistentContainer.viewContext)
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let performer = fetchedResultsController.object(at: indexPath)
        let cell = UITableViewCell()
        cell.textLabel?.text = performer.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let performer = fetchedResultsController.object(at: indexPath)
            persistentContainer.viewContext.delete(performer)
            try? persistentContainer.viewContext.save()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.performer = fetchedResultsController.object(at: indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TableViewController : NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let performer = fetchedResultsController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = performer.name
            }
        }
    }
}

extension TableViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
