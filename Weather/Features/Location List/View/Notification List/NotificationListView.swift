//
//  NotificationList.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit

class NotificationListView: UIView {
    
    // MARK: - Outlets -
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var lblDate: UILabel!
    
    // MARK: - Variables -
    
    var list: WeatherReport! {
        didSet {
            lblTitle.text = list.description.capitalized
            lblDate.text = list.dt_txt
        }
    }
}
