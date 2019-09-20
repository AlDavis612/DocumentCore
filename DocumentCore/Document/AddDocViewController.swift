//
//  AddDocViewController.swift
//  Document
//
//  Created by Alex Davis on 8/29/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//

import UIKit

class AddDocViewController: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var TextViewField: UITextView!
    
    var existingDoc: DocumentCore?
   
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NameField.delegate = self as! UITextFieldDelegate
        TextViewField.delegate = self as! UITextViewDelegate
        
        NameField.text = existingDoc?.name
        
        if let size = existingDoc?.size {
            TextViewField.text = "\(size)"
        } 
    }
    
    
    
    @IBAction func saveDoc(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        let date = dateFormatter.string(from: Date())
        let date2 = dateFormatter.date(from: date)
        let name = NameField.text
        let textF = TextViewField.text ?? ""
        let size = Int32(textF) ?? 0
        
        
        if let document = DocumentCore(name: name, size: size, date: date2) {
            do {
                let managedContext = document.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            }
            catch {
                print("Document could not be saved")
            }
        }
    }
    

}

extension AddDocViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

