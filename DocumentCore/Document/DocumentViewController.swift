//
//  DocumentViewController.swift
//  Document
//
//  Created by Alex Davis on 8/28/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//

import UIKit
import CoreData

class DocumentViewController: UIViewController {

    @IBOutlet weak var docTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var documents = [DocumentCore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DocumentCore> = DocumentCore.fetchRequest()
        
        do {
            documents = try managedContext.fetch(fetchRequest)
            docTableView.reloadData()
        } catch {
            print("Fetch failed")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addNewDoc(_ sender: Any) {
    }
    
    func deleteDoc(at indexPath: IndexPath) {
        let document = documents[indexPath.row]
        
        if let managedContext = document.managedObjectContext {
            managedContext.delete(document)
            
            do {
                try managedContext.save()
                
                self.documents.remove(at: indexPath.row)
                
                docTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Delete Error")
                
                docTableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
        }
    }
}

extension DocumentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = docTableView.dequeueReusableCell(withIdentifier: "docCell", for: indexPath)
        let doc = documents[indexPath.row]
        
        cell.textLabel?.text = doc.name
        
        if let date = doc.date {
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDoc(at: indexPath)
        }
    }
}

extension DocumentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
}



