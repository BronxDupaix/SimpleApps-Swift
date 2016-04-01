//
//  InterfaceController.swift
//  SimpleWatchMap-Swift WatchKit Extension
//
//  Created by Bronson Dupaix on 3/31/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    
    @IBOutlet var map: WKInterfaceMap!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        print("Awaken with context")
        
        // Using storyboard change the accessability settings to enabled for the map view
        
        let mapLocation = CLLocationCoordinate2D(latitude: 37, longitude: -122)
        
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        
        let mapRect = MKMapRect(origin:MKMapPoint(x: 37, y: -122)  , size:MKMapSize(width: 20, height: 20 ) )
        
        self.map.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Purple)
        
        self.map.setRegion(MKCoordinateRegion(center:mapLocation, span: coordinateSpan))
        
         //   self.map.setVisibleMapRect(mapRect)
        
        

        
    }

    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
