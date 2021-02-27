//
//  LocationListView.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit

// MARK: - View Delegate -
@objc protocol LocationListDelegate {
    func backNavigation()
    func addBookMark()
}

class LocationListView: UIView {
    
    // MARK: - Outlets -
    @IBOutlet weak var delegate: LocationListDelegate?
    @IBOutlet private weak var stackLocation: UIStackView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var lblCityName: UILabel!
    
    // MARK: - Variable -
    var cityName: String! {
        didSet {
            lblCityName.text = cityName
        }
    }
    
    var weatherForcast: [WeatherReport]! {
        didSet {
            addWeather(weatherForcast)
        }
    }
    
    // MARK: - View Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        addNoDataView()
    }
}

// MARK: - View Action -
private extension LocationListView {
    
    @IBAction final private func btnBackAction() {
        guard let delegate = delegate else { return }
        delegate.backNavigation()
    }
    
    @IBAction final private func btnBookMarkDeleteAction() {
        guard let delegate = delegate else { return }
        delegate.addBookMark()
    }
}

// MARK: - Add Weather Forcecast -
private extension LocationListView {
    
    final private func removeNoData() {
        for view in stackLocation.arrangedSubviews { view.removeFromSuperview() }
    }
    
    final private func addWeather(_ list: [WeatherReport]) {
        removeNoData()
        
        list.enumerated().forEach { (listing) in
            let locationView = getXIB(type: NotificationListView.self)
            locationView.list = listing.element
            stackLocation.addArrangedSubview(locationView)
        }
        if list.isEmpty { addNoDataView() }
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    final private func addNoDataView() {
        removeNoData()
        let externalSegment  = getXIB(type: NoDataView.self)
        externalSegment.noDataType = .notification
        stackLocation.addArrangedSubview(externalSegment)
    }
}
