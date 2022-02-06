//
//  WeatherForecastDayTVC.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import UIKit

class WeatherForecastDayTVC: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var tempDescLbl: UILabel!
    @IBOutlet weak var tempIconImgView: UIImageView!

    var item : WeatherForecast? {
        didSet {
            dateLbl?.text = item?.dayDate
            tempLbl?.text = UnitManager.shared.getCurrentTemp(temp: item?.temp ??                                                               0)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellUI(){
        self.dateLbl?.textColor = .Colors.primaryTextColor
        self.dateLbl?.font = UIFont.systemFont(ofSize: 20)
        
        self.tempLbl?.textColor = .Colors.primaryTextColor
        self.tempLbl?.font = UIFont.systemFont(ofSize: 30)
        
        self.tempDescLbl?.textColor = .Colors.secondryTextColor
        self.tempDescLbl?.font = UIFont.systemFont(ofSize: 12)
    }
}
