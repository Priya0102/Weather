//
//  Tour+CoreDataProperties.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//
//

import Foundation
import CoreData


extension Tour {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tour> {
        return NSFetchRequest<Tour>(entityName: "Tour")
    }

    @NSManaged public var country: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var color: String?
    @NSManaged public var city: String?
    @NSManaged public var time: String?

}
