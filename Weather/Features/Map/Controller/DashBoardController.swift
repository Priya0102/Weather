//
//  DashBoardController.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit
import MapKit

class DashBoardController: UIViewController {
    
    // MARK: - View Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshMap()
    }
}

// MARK: - Prepare View  -
private extension DashBoardController {
    
    final private func refreshMap() {
        if let view = view as? DashBoardView {
            view.refreshAnnotations = true
        }
    }
}

// MARK: - DashBoard Delegate -
extension DashBoardController: DashBoardDelegate {
    
    func settingsNavigation() {
        
    }
    
    func goToAddCity(_ coordinate: CLLocationCoordinate2D) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "LocationListController") as? LocationListController {
            controller.coordinate = coordinate
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func viewCity(_ annotation: TourAnnotation) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "LocationListController") as? LocationListController {
            controller.coordinate = annotation.coordinate
            controller.isBookMarked = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
