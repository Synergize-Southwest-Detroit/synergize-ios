//
//  EventManager.swift
//  Synergize Southwest Detroit
//
//  Created by Giancarlo Anemone on 4/9/15.
//  Copyright (c) 2015 Giancarlo Anemone. All rights reserved.
//

import UIKit

private let _EventManager = EventManager()
private let BASE_URL: String = "ganemone.pythonanywhere.com/api/"

class EventManager: NSObject {
    
    var currentPage = 1
    var totalPages = 1
    
    var events: Dictionary<Int, Array<Event>> = Dictionary<Int, Array<Event>>(minimumCapacity: 5)
    
    class var sharedInstance: EventManager { return _EventManager }
    class var http: AFHTTPRequestOperationManager {
    let manager = AFHTTPRequestOperationManager(baseURL: NSURL(string: BASE_URL))
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        return manager
    }
    
    func load(done: ((NSError!) -> Void)!) {
        let params = [
            "page": self.currentPage
        ]
        EventManager.http.GET("/events", parameters: params,
            success: { (NSURLSessionDataTask, response) -> Void in
                self.currentPage++
                let json = response as Dictionary<String, AnyObject>
                self.setDataFromResponse(json)
                if done != nil {
                    done(nil)
                }
                self.emitChanged()
                
            },
            { (NSURLSessionDataTask, NSError) -> Void in
                NSLog("Error loading events: %@", NSError)
                if done != nil {
                    done(NSError)
                }
                self.emitError()
        })
    }
    
    func setDataFromResponse(rawData: Dictionary<String, AnyObject>) {
        let num_results = rawData["num_results"]! as Int
        let objects = rawData["objects"]! as Array<AnyObject>
        let page = rawData["page"]! as Int
        self.totalPages = rawData["total_pages"]! as Int
        
        self.clearPage(page)
        
        for obj in objects {
            self.events[page]?.append(Event(data: obj as Dictionary<String, AnyObject>));
        }
    }
    
    func emitChanged() {
        
    }
    
    func emitError() {
        
    }
    
    internal func clearPage(page: Int) {
        self.events[page] = Array<Event>()
    }

}
