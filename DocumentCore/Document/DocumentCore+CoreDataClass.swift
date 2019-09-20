//
//  DocumentCore+CoreDataClass.swift
//  Document
//
//  Created by Alex Davis on 9/20/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//
//

import UIKit
import CoreData

@objc(DocumentCore)
public class DocumentCore: NSManagedObject {
    var date: Date? {
        get {
            return rawDateModified as Date?
        }
        set {
            rawDateModified = newValue as NSDate?
        }
    }

    convenience init?(name: String?, size: Int32, date: Date?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
       
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: DocumentCore.entity(), insertInto: managedContext)
        
        self.name = name
        self.size = size
        self.date = date
        
    }
    
}
