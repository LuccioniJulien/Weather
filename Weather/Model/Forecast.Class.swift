//
//  Forecast.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit
import SwiftyJSON

class Forecast {
    
    var icon:String
    var temperature:Double
    var summary:String
    var windSpeed:Double
    var pressure:Double
    var humidity:Double
    var uvIndex:Int
    var hourlySummary:String
    var dailySummary:String
    var hourlyInfo:[(Double,String,Double,Double)] = []
    var dailyInfo:[(Double,String,Double,Double)] = []

    init(json:JSON) {
        
        let temp:JSON = json["currently"]
        
        self.icon = temp["icon"].stringValue
        self.temperature = temp["temperature"].double ?? 0.0
        self.summary = temp["summary"].stringValue
        self.windSpeed = temp["windSpeed"].double ?? 0.0
        self.pressure = temp["pressure"].double ?? 0.0
        self.humidity = temp["humidity"].double ?? 0.0
        self.uvIndex = temp["uvIndex"].int ?? 0
        self.hourlySummary = json["hourly"]["summary"].stringValue
        self.dailySummary = json["daily"]["summary"].stringValue
        
        self.setHourlyInfo(json["hourly"]["data"].arrayValue)
        self.setDailyInfo(json["daily"]["data"].arrayValue)
    }
    
    func setHourlyInfo(_ data:[JSON]){
        for item in data {
            let time:Double = item["time"].double ?? 0.0
            let icon:String = item["icon"].stringValue
            let humidity:Double = item["humidity"].double ?? 0.0
            let temperature:Double = item["temperature"].double ?? 0.0
            
            self.hourlyInfo.append((time,icon,humidity,temperature))
        }
    }
    
    func setDailyInfo(_ data:[JSON]){
        for item in data{
            let time:Double = item["time"].double ?? 0
            let icon:String = item["icon"].stringValue
            let temperatureLow:Double = item["apparentTemperatureLow"].double ?? 0.0
            let temperatureHight:Double = item["apparentTemperatureHigh"].double ?? 0.0
            self.dailyInfo.append((time,icon,temperatureLow,temperatureHight))
        }
    }
    
}
