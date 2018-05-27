//
//  Globals.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import Foundation


public class Globals{
    static var sharedInstance = Globals()
    
    var secretKey       :String
    var contentType     :String
    
    init(){
        secretKey       = "2e51dbca61b486e78e47c4f1a3676d55"
        contentType     = "application/json"
    }
}
