//
//  WeatherDetailsInfoCVC.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import UIKit

class WeatherDetailsInfoCVC: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var bagView: UIView!

    var item : WeatherInfo? {
        didSet {
            titleLbl?.text = item?.title
            valueLbl?.text = item?.value
            if let icon = item?.icon {
                iconImgView?.image = UIImage(systemName: icon)
            }else {
                iconImgView?.image = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCellUI(){
        self.titleLbl?.textColor = .Colors.primaryTextColor
        self.titleLbl?.font = UIFont.systemFont(ofSize: 16)
        
        self.valueLbl?.textColor = .Colors.primaryTextColor
        self.valueLbl?.font = UIFont.systemFont(ofSize: 30)
        
        self.bagView.backgroundColor = .Colors.thirdBackGroundColor.withAlphaComponent(0.7)
    }
}
