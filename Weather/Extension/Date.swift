//
//  Date.swift
//  Weather
//
//  Created by Julien luccioni on 13/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import Foundation

extension Date {
    func toString(_ format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format
        let strDate = dateFormatter.string(from: self)
        return strDate
    }
}
