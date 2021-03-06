//
//  TourAnnotation.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit
import MapKit

class TourAnnotation: MKPointAnnotation {
    
    // MARK: - Variable -
    var color: String?
    var time: String?
    
    // MARK: - Init -
    init(_ latitude: CLLocationDegrees,_
            longitude: CLLocationDegrees,
         title: String,
         subtitle: String,
         color: String,
         time: String) {
        
        super.init()
        
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = title
        self.subtitle = subtitle
        self.time = time
        self.color = color
    }
}
