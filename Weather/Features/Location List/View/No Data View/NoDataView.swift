//
//  NoDataView.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import UIKit

enum NoDataType {
    case notification
}

class NoDataView: UIView {
    
    // MARK: - Outlets -
    @IBOutlet weak private var imgNoData: UIImageView!
    @IBOutlet weak private var lblNoData: UILabel!
    
    // MARK: - Variables -
    var noDataType: NoDataType! {
        didSet {
            
            switch noDataType {
            
            case .notification:
                imgNoData.image = UIImage(named: "icon_No_Notify")
                lblNoData.text = "No Weather Forecast data Yet"
                
            case .none:
                break
                
            }
        }
    }
}
