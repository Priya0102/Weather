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
                
        if let url = URL(string: "https://run.mocky.io/v3/15af2f52-e0a8-4a90-b837-6ece725ae641") {
            UIApplication.shared.open(url)
        }
    }
    
    func goToAddCity(_ coordinate: CLLocationCoordinate2D) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "LocationListController") as? LocationListController {
            controller.coordinate = coordinate
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func viewCity(_ annotation: TourAnnotation) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "LocationListController") as? LocationListController {
            controller.time = annotation.time ?? ""
            controller.coordinate = annotation.coordinate
            controller.isBookMarked = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
