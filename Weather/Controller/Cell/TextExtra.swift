//
//  TextExtra.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit

class TextExtra: UITableViewCell {

    @IBOutlet weak var firstSubHeader: UILabel!
    @IBOutlet weak var secondSubHeader: UILabel!
    @IBOutlet weak var firstContent: UILabel!
    @IBOutlet weak var secondContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    func configure(content:((String,String),(String,String))){
        self.firstSubHeader.text = content.0.0
        self.secondSubHeader.text = content.1.0
        self.firstContent.text = content.0.1
        self.secondContent.text = content.1.1
    }
    
}
