//
//  DailyForecastInfos.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit

class DailyForecastInfos: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperatureMin: UILabel!
    @IBOutlet weak var temperatureMax: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    func configure(infos:(Double,String,Double,Double)){
        self.day.text = Date(timeIntervalSince1970: infos.0).toString("EEEE")
        self.icon.image = UIImage(named: infos.1)!
        self.temperatureMin.text = String(infos.2).prefix(2) + "°C"
        self.temperatureMax.text = String(infos.3).prefix(2) + "°C"
    }
}
