//
//  List.swift
//  Weather
//
//  Created by Julien luccioni on 12/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit

class List: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var customDelegate:ListDelegate?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: "Town", bundle: nil), forCellReuseIdentifier: "Town")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CitiesData.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "Town", for: indexPath) as! Town
        cell.city = CitiesData.list[indexPath.row]
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customDelegate?.showDetails(city: CitiesData.list[indexPath.row])
    }

}
