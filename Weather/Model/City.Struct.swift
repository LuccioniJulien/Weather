//
//  City.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import Foundation
import CoreLocation

struct City {
    var name: String
    var coordinates: CLLocationCoordinate2D
    var forecast: Forecast?
    
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
    }
}
