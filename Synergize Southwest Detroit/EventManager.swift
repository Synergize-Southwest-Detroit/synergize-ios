//
//  EventManager.swift
//  Synergize Southwest Detroit
//
//  Created by Giancarlo Anemone on 4/9/15.
//  Copyright (c) 2015 Giancarlo Anemone. All rights reserved.
//

import UIKit

private let _EventManager = EventManager()

class EventManager: NSObject {
    
    var events: Dictionary<Int, Array<Event>> = Dictionary<Int, Array<Event>>(minimumCapacity: 5)
    
    class var sharedInstance: EventManager { return _EventManager }
    
}
