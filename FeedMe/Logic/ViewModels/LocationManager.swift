//
//  LocationManager.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import Foundation
import CoreLocation

// Observable class for managing user's location

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager = CLLocationManager()
    
    var location: CLLocationCoordinate2D?
    var error: Error?
    
    override init() {
        super.init()
        locationManager.delegate = self
        // Request permission to use user location
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Setting the observable location property on callback from CLLocationManagerDelegate
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        self.error = error
    }
    
    // Requesting location or setting an error based on authorization status changes
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways ||
            manager.authorizationStatus == .restricted {
            manager.requestLocation()
        } else if manager.authorizationStatus == .denied {
            self.error = CLError.init(.denied)
        }
    }
}
