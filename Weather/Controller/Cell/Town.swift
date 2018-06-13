//
//  Town.swift
//  Weather
//
//  Created by Julien luccioni on 12/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit

class Town: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    var city:City? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
        self.name.text = city?.name
    }
    
}
