//
//  RequestManager.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class RequestManager {
    
    static var instance = RequestManager()

    private let baseApi = "https://api.darksky.net/forecast/"
    private let keyApi = "7eaedb040777880ed9e876f46f5ee59e"
    private let langParam = "lang=en"
    private let unitParam = "units=si"
    
    func getForecast(city:City , _ success: @escaping (Forecast) -> (),_ failure: @escaping (String) -> ())
    {
        let coordinate:CLLocationCoordinate2D = city.coordinates
        let url = "\(baseApi)\(keyApi)/\(coordinate.latitude),\(coordinate.longitude)?\(langParam)&\(unitParam)"

        Alamofire.request(url).responseJSON{ response in
            if let data = response.result.value
            {
                success(Forecast(json:JSON(data)))
            }
            else if let data:Error = response.result.error
            {
                failure(data.localizedDescription)
            }
        }
    }
}
