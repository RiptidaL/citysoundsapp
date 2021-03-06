//
//  EventDetailViewController.swift
//  CitySounds
//
//  Created by Scott on 2/20/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MapKit
import CoreLocation

class EventDetailViewController: UIViewController {

   
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventAddress: UILabel!
    @IBOutlet weak var eventGenre: UILabel!
    @IBOutlet weak var eventPrice: UILabel!
    @IBOutlet weak var eventArtists: UILabel!
        
    @IBOutlet var mapView: MKMapView!
    
   
    var eventDetails = Event()
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Set navigation title to event's name
//        self.title = eventDetails.name
        
        // Retrieve event details
        getEventDetails()
//        getMapView()
        
        
      
        
        
        
    }
    

    func getEventDetails() {
        
        self.title = eventDetails.name
        eventDate.text = eventDetails.date
        eventTime.text = eventDetails.time
        eventLocation.text = eventDetails.location
        eventAddress.text = eventDetails.address
        eventGenre.text = eventDetails.genre
        eventPrice.text = eventDetails.price
        eventArtists.text = eventDetails.artists
        
        
    
    }
    
//    func getMapView() {
//        let geocoder = CLGeocoder()
//        let location = eventDetails.address
//
//        geocoder.geocodeAddressString(location) { [weak self] placemarks, error in
//        if let placemark = placemarks?.first, let location = placemark.location {
//
//            let mark = MKPlacemark(placemark: placemark)
//
//            if var region = self?.mapView.region {
//                region.center = location.coordinate
//                region.span.longitudeDelta /= 8.0
//                region.span.latitudeDelta /= 8.0
//                self?.mapView.setRegion(region, animated: true)
//                self?.mapView.addAnnotation(mark)
//            }
//            }
//
//        }
//
//
//
//
//    }

    
    

}
