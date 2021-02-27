//
//  DashBoardView.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit
import MapKit

// MARK: - View Delegate -
@objc protocol DashBoardDelegate {
    func settingsNavigation()
    func goToAddCity(_ coordinate: CLLocationCoordinate2D)
    func viewCity(_ annotation: TourAnnotation)
}

class DashBoardView: UIView {
    
    // MARK: - Outlets -
    @IBOutlet weak var delegate: DashBoardDelegate?
    @IBOutlet final private weak var mapView: MKMapView!
    
    // MARK: - Variable -
    final private let identifier = "Tourism"
    
    var refreshAnnotations: Bool! {
        didSet {
            
        }
    }
    
    // MARK: - View Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
}

// MARK: - Prepare View -
private extension DashBoardView {
    
    final private func prepareView() {
        mapView.showsUserLocation = true
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(handleTap))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - View Action -
private extension DashBoardView {
    
    @IBAction final private func btnListAction(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.settingsNavigation()
    }
    
    @objc final private func handleTap(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .ended {
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            guard let delegate = delegate else { return }
            delegate.goToAddCity(coordinate)
        }
    }
}

extension DashBoardView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView) {
        if let eventAnnotation = view.annotation as? TourAnnotation {
            plog(eventAnnotation)
            guard let delegate = delegate else { return }
            delegate.viewCity(eventAnnotation)
        }
    }
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = MKMarkerAnnotationView()
        guard let annotation = annotation as? TourAnnotation else { return nil }
        
        if let dequedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            annotationView = dequedView
        } else{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView.markerTintColor = annotation.color?.toUIColor()
        annotationView.glyphImage = UIImage(named: "tour")
        annotationView.glyphTintColor = .red
        annotationView.clusteringIdentifier = identifier
        return annotationView
    }
}
