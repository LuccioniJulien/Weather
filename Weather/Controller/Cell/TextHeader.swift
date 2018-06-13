//
//  HourlyForecastHeader.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit

class TextHeader: UITableViewCell {

    @IBOutlet weak var summary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(summary:String){
        self.summary.text = summary
    }
}
