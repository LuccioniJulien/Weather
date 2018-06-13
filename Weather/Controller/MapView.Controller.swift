//
//  MapView.swift
//  Weather
//
//  Created by Julien luccioni on 11/06/2018.
//  Copyright © 2018 Julien luccioni. All rights reserved.
//

import UIKit
import MapKit
import YNDropDownMenu

class MapView: UIViewController,MKMapViewDelegate,ListDelegate,UISearchBarDelegate {

    @IBOutlet var map: MKMapView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var selectedCity:City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        // set up the listView
        let frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 40)
        let list = Bundle.main.loadNibNamed("List", owner: nil, options: nil) as! [UIView]
        (list[0] as! List).customDelegate = self
        // resize of the List in order to enable to scroll to the bottom
        (list[0] as! List).frame = CGRect.init(x: 0, y: 104, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 104)
        let view = YNDropDownMenu(frame:frame, dropDownViews: list, dropDownViewTitles: ["See all locations"])
        view.setImageWhen(normal: UIImage(named: "arrow_nor"), selected: UIImage(named: "arrow_sel"), disabled: UIImage(named: "arrow_dim"))
        self.view.addSubview(view)
        
        // set up the annotations on the map
        map.delegate = self
        self.title = "Weather"
        for city in CitiesData.list{
            let pin = MKPointAnnotation()
            pin.coordinate = city.coordinates
            pin.title = city.name
            map.addAnnotation(pin)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        map.deselectAnnotation(view.annotation, animated: true)
        performSegue(withIdentifier: "SegueWeather", sender: view)
    }
    
    func showDetails(city:City) {
        // delegate implementation
        self.selectedCity = city
        performSegue(withIdentifier: "SegueWeather", sender: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView:WeatherView = segue.destination as? WeatherView{
            
            // if performSegue throught the list delegate
            // selectedCity isn`t nil
            if let city:City = self.selectedCity {
                nextView.selectedCity = city
                selectedCity = nil
                return
            }
            
            // if performSegue throught the Annotation
            if let anoView:MKAnnotationView = sender as? MKAnnotationView{
                nextView.selectedCity = City(name: ((anoView.annotation?.title)!)!, coordinates: (anoView.annotation?.coordinate)!)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Add an annotation on the map with the first result of the request
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = map.region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                let alert = UIAlertController(title: "Error", message: "\(error ?? "error" as! Error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                return
            }

            let temp = response.mapItems[0]
            let pin = MKPointAnnotation()
            pin.coordinate = temp.placemark.coordinate
            pin.title = searchBar.text
            
            let isAlreadyPinned = self.map.annotations.contains(where: { (anon) -> Bool in
                let latitude = anon.coordinate.latitude
                let longitude = anon.coordinate.longitude
                return latitude == pin.coordinate.latitude && longitude == pin.coordinate.longitude
            })
            
            if(!isAlreadyPinned){
                self.map.addAnnotation(pin)
            }
            
            let span = MKCoordinateSpanMake(0.90, 0.90)
            let region = MKCoordinateRegion(center:temp.placemark.coordinate, span: span)
            self.map.setRegion(region, animated: true)
            
            searchBar.text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
    }
}

