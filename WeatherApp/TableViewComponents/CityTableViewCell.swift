//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-30.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
