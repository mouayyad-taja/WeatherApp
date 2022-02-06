//
//  SettingsTVC.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import UIKit

class SettingsTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!

    var item : UnitKey? {
        didSet {
            titleLbl?.text = item?.title
        }
    }
    
    var isSelectedItem: Bool = false {
        didSet{
            self.accessoryType = isSelectedItem ? .checkmark : .none
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
        self.titleLbl?.textColor = isSelectedItem ? .Colors.primaryTextColor : .Colors.secondryTextColor
        self.titleLbl?.font = UIFont.systemFont(ofSize: 18)
    }
}
