//
//  LIDownloadDB.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit
import CoreData

// MARK: - Download Path -
struct TourDetails {
    var country = ""
    var city = ""
    var latitude: Double  = 0
    var longitude: Double  = 0
    var color = ""
    var time = ""
}

// MARK: - Convert to storable entity -
extension TourDetails: Entity {
    
    public func toStorable(in context: NSManagedObjectContext, withSuperClass superClass: NSManagedObject?, isMediaUpate: Bool) -> Tour? {
        
        let predicate = NSPredicate(format: "self.time = %@", time)
        
        let coreDataTour = Tour.getOrCreateSingle(with: predicate, from: context)
        
        coreDataTour.city = city.lowercased()
        coreDataTour.country = country.lowercased()
        coreDataTour.latitude = latitude
        coreDataTour.longitude = longitude
        coreDataTour.time = time
        coreDataTour.color = UIColor.random().toHexString()
        
        return coreDataTour
    }
}

// MARK: - Get Modal -
extension Tour: Storable {
    
    var primaryKey: String {
        get {
            return time ?? ""
        }
    }
    
    var model: TourDetails {
        get {
            return TourDetails(country:  country ?? "",
                               city: city ?? "",
                               latitude: latitude,
                               longitude: longitude,
                               time: time ?? "")
        }
    }
}

extension TourDetails {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension CLLocation {
    
    func fetchCityAndCountry(completion: @escaping (_ city: String?,
                                                    _ country:  String?,
                                                    _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality,
                                                               $0?.first?.country, $1) }
    }
}
