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
    
    func obtainUserLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    // Setting the observable location property on callback from CLLocationManagerDelegate
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case CLError.locationUnknown:
                print("location unknown")
            case CLError.denied:
                print("denied")
            default:
                print("other Core Location error")
            }
        } else {
            print("other error:", error.localizedDescription)
        }
        self.error = error
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        obtainUserLocation()
    }
}
