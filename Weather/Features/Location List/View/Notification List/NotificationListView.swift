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
    @IBOutlet weak private var lblTemp: UILabel!
    
    // MARK: - Variables -
    
    var list: WeatherReport! {
        didSet {
            lblTitle.text = list.description.capitalized
            lblTemp.text = "Temperature is " + list.temp
            lblDate.text = list.dt_txt
        }
    }
}
