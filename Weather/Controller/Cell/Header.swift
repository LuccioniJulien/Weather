//
//  Header.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit

class Header: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(temperature:Double,summary:String,icon:String) {
        self.summary.text = summary
        self.temperature.text = String(temperature) + " C°"
        self.imgView.image = UIImage(named: icon)!
    }
    
}
