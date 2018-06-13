//
//  WeatherView.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit
import SwiftyGif

class WeatherView: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tbWeather: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingGif: UIImageView!
    
    var selectedCity:City?
    var extraForecast:[((String,String),(String,String))] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbWeather.dataSource = self
        tbWeather.delegate = self
        
        self.title = selectedCity?.name
        self.registerCell()
        // set loading gif
        self.tbWeather.isHidden = true
        let gif = UIImage(gifName: "sun.gif")
        self.loadingGif.setGifImage(gif)
        self.loadingGif.loopCount = -1
        // if call Api is succes
        let success:(Forecast)->() = { forecast in
            self.selectedCity!.forecast = forecast
            
            var firstExtra = ("Humidity",String(Int(forecast.humidity * 100)) + "%")
            let str:String = String(forecast.windSpeed).prefix(1) + " km/h"
            var secondExtra = ("Wind speed",str)
            self.extraForecast.append((firstExtra,secondExtra))
            
            firstExtra = ("Pressure",String(forecast.pressure).prefix(4) + "hPa")
            secondExtra = ("UV Index",String(String(forecast.uvIndex).prefix(1)))
            self.extraForecast.append((firstExtra,secondExtra))
            
            self.tbWeather.reloadData()
            self.tbWeather.isHidden = false
            self.loadingView.isHidden = true
        }
        // if call Api fail
        let failure:(String)->() = { alert in
            let handler:(UIAlertAction)->() = { err in
                let gif = UIImage(gifName: "error.gif")
                self.loadingGif.setGifImage(gif)
                self.loadingGif.loopCount = -1
            }
            let alert = UIAlertController(title: "Error", message: "\(alert)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
            self.present(alert, animated: true)
        }
        // call Api
        RequestManager.instance.getForecast(city:selectedCity!,success,failure)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            // selectedCity?.forecast?.hourlyInfo.count
            let nbCell:Int = selectedCity?.forecast?.hourlyInfo.count ?? 0
            return nbCell >= 0 && nbCell < 11 ? nbCell : 10
        case 3:
            return 1
        case 4:
            return  selectedCity?.forecast?.dailyInfo.count ?? 0
        case 5:
            return 1
        case 6:
            return  extraForecast.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let forecast:Forecast = selectedCity?.forecast {
            switch indexPath.section {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! Header
                    let temperature:Double = forecast.temperature
                    let summary:String = forecast.summary
                    let icon:String = forecast.icon
                    cell.configure(temperature:temperature, summary:summary , icon:icon )
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TextHeader", for: indexPath) as! TextHeader
                    cell.configure(summary: forecast.hourlySummary)
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyForecastInfos", for: indexPath) as! HourlyForecastInfos
                    cell.configure(infos:forecast.hourlyInfo[indexPath.row])
                    return cell
                case 3:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TextHeader", for: indexPath) as! TextHeader
                    cell.configure(summary: forecast.dailySummary)
                    return cell
                case 4:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DailyForecastInfos", for: indexPath) as! DailyForecastInfos
                    cell.configure(infos: forecast.dailyInfo[indexPath.row])
                    return cell
                case 5:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TextHeader", for: indexPath) as! TextHeader
                        cell.configure(summary: "Extra Informations")
                    return cell
                case 6:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TextExtra", for: indexPath) as! TextExtra
                    cell.configure(content: extraForecast[indexPath.row])
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
                    return cell
            }
    }
        let cell = UITableViewCell()
        cell.textLabel?.text = "No Data"
        return cell
    }
    
    func registerCell() {
        // register xib files to the tableView
        tbWeather.register(UINib(nibName: "Header", bundle: nil), forCellReuseIdentifier: "Header")
        tbWeather.register(UINib(nibName: "TextHeader", bundle: nil), forCellReuseIdentifier: "TextHeader")
        tbWeather.register(UINib(nibName: "HourlyForecastInfos", bundle: nil), forCellReuseIdentifier: "HourlyForecastInfos")
        tbWeather.register(UINib(nibName: "DailyForecastInfos", bundle: nil), forCellReuseIdentifier: "DailyForecastInfos")
        tbWeather.register(UINib(nibName: "TextExtra", bundle: nil), forCellReuseIdentifier: "TextExtra")
    }
}
