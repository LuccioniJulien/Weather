//
//  HourlyForecastInfos.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit

class HourlyForecastInfos: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    func configure(infos:(Double,String,Double,Double)){
        self.time.text = Date(timeIntervalSince1970: infos.0).toString("HH")
        self.icon.image = UIImage(named: infos.1)!
        self.humidity.text = String(infos.2 * 100).prefix(2) + " %"
        self.temperature.text = String(infos.3).prefix(2) + " °C"
    }
    
}
