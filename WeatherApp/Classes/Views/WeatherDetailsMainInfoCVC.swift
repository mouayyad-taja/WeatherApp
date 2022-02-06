//
//  WeatherDetailsMainInfoCVC.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import UIKit

class WeatherDetailsMainInfoCVC: UICollectionViewCell {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var tempDescLbl: UILabel!
    @IBOutlet weak var tempIconImgView: UIImageView!

    var item : WeatherMainInfo? {
        didSet {
            cityLbl?.text = item?.cityName
            dateLbl?.text = item?.dateTime
            tempLbl?.text = UnitManager.shared.getCurrentTemp(temp: item?.temp ??                                                               0)
            lowTempLbl?.text = "L: \(UnitManager.shared.getCurrentTemp(temp: item?.lowTemp ?? 0))"
            highTempLbl?.text = "H: \(UnitManager.shared.getCurrentTemp(temp: item?.highTemp ?? 0))"
            tempDescLbl?.text = item?.weather?.weatherDescription
            if let icon = item?.weather?.icon {
                tempIconImgView?.image = UIImage(named: icon)
            }else {
                tempIconImgView?.image = nil
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCellUI(){
        self.cityLbl?.textColor = .Colors.primaryTextColor
        self.cityLbl?.font = UIFont.systemFont(ofSize: 50)
        
        self.tempLbl?.textColor = .Colors.primaryTextColor
        self.tempLbl?.font = UIFont.systemFont(ofSize: 40)
        
        self.lowTempLbl?.textColor = .Colors.primaryTextColor
        self.lowTempLbl?.font = UIFont.systemFont(ofSize: 16)

        self.highTempLbl?.textColor = .Colors.primaryTextColor
        self.highTempLbl?.font = UIFont.systemFont(ofSize: 16)

        self.tempDescLbl?.textColor = .Colors.primaryTextColor
        self.tempDescLbl?.font = UIFont.systemFont(ofSize: 16)

        self.dateLbl?.textColor = .Colors.primaryTextColor
        self.dateLbl?.font = UIFont.systemFont(ofSize: 14)
    }
    

}
