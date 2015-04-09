//
//  Event.swift
//  Synergize Southwest Detroit
//
//  Created by Giancarlo Anemone on 4/9/15.
//  Copyright (c) 2015 Giancarlo Anemone. All rights reserved.
//

import UIKit
import MapKit;


private

class Event: NSObject {
    
    var title: String
    var desc: String
    var startDate: NSDate
    var endDate: NSDate
    var address: String
    var addressName: String
    var location: CLLocation
    
    init(data: Dictionary<String, AnyObject>) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        self.title = data["title"]! as String
        self.desc = data["description"]! as String
        self.startDate = dateFormatter.dateFromString(data["start"]! as String)!
        self.endDate = dateFormatter.dateFromString(data["end"]! as String)!
        self.address = data["address"]! as String
        self.addressName = data["display_address"]! as String;
    }
}
