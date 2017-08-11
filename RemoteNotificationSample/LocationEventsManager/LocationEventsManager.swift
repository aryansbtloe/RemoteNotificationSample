//
//  LocationEventsManager.swift
//  RemoteNotificationSample
//
//  Created by Alok Singh on 11/08/17.
//  Skype           : alok.singh.confident
//  Phone/Whatsapp  : 8287757210
//  Email           : alok.singh.confident@gmail.com
//  Official Email  : alok.k.singh@orahi.com
//  Github          : https://github.com/aryansbtloe
//  LinkedIn        : https://in.linkedin.com/in/alok-kumar-singh-09141164
//  Facebook        : https://www.facebook.com/aryansbtloe
//  Stack OverFlow  : http://stackoverflow.com/users/911270/alok-singh
//  CocoaControls   : https://www.cocoacontrols.com/authors/aryansbtloe
//  Copyright (c) 2017 Orahi. All rights reserved.
//

import Foundation
import CoreLocation

typealias LEMLocationEvent = (_ location :CLLocation) ->()

func Lem()->LocationEventsManager{
    return LocationEventsManager.sharedInstance
}

class LocationEventsManager: NSObject,CLLocationManagerDelegate{
    
    static let sharedInstance : LocationEventsManager = {
        let instance = LocationEventsManager()
        return instance
    }()
    
    fileprivate var lm = CLLocationManager()
    fileprivate var locationDelievered = false
    fileprivate var locationUpdateEvent : LEMLocationEvent?
    
    fileprivate override init() {
    }
    
    func takePermission(){
        lm.requestAlwaysAuthorization()
    }
    
    func fetchingCurrentLocationOnce(currentLocation:@escaping LEMLocationEvent){
        self.locationUpdateEvent = currentLocation
        lm.requestAlwaysAuthorization()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        lm.startUpdatingLocation()
        locationDelievered = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locationDelievered {
            locationUpdateEvent?(locations.last!)
            locationDelievered = true
            lm.stopUpdatingLocation()
        }
    }
}
