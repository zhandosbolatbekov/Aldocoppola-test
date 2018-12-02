//
//  MyLocationViewController.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/28/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit
import MapKit

class MyLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLocation = CLLocation(latitude: 43.2499, longitude: 76.9436)
        centerMapOnLocation(location: initialLocation)
        
        let artwork = Artwork(title: "Aldo Coppola",
                              locationName: "Almaty",
                              discipline: "Beauty Saloon",
                              coordinate: CLLocationCoordinate2D(latitude: 43.2499, longitude: 76.9436))
        mapView.addAnnotation(artwork)
        // Do any additional setup after loading the view.
    }
    
    let regionRadius: CLLocationDistance = 1000
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
