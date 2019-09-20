//
//  DocumentCore+CoreDataProperties.swift
//  Document
//
//  Created by Alex Davis on 9/20/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//
//

import Foundation
import CoreData


extension DocumentCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DocumentCore> {
        return NSFetchRequest<DocumentCore>(entityName: "DocumentCore")
    }

    @NSManaged public var name: String?
    @NSManaged public var size: Int32
    @NSManaged public var rawDateModified: NSDate?

}
