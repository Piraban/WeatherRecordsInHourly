//
//  Weather.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import Foundation


class Weather{
    var time                : String
    var summary             : String
    var icon                : String
    var precipIntensity     : NSNumber
    var precipProbability   : NSNumber
    var temperature         : Double
    var apparentTemperature : Double?
    var dewPoint            : Double?
    var humidity            : Double?
    var pressure            : Double?
    var windSpeed           : Double?
    var windGust            : Double?
    var windBearing         : Double?
    var cloudCover          : Double?
    var uvIndex             : Double?
    var visibility          : Double?
    var ozone               : Double?
        
    init(){
        time               = ""
        summary            = ""
        icon               = ""
        precipIntensity    = 0
        precipProbability  = 0
        temperature        = 0.0
        dewPoint           = 0.0
        humidity           = 0.0
        pressure           = 0.0
        windSpeed          = 0.0
        windGust           = 0.0
        windBearing        = 0.0
        cloudCover         = 0.0
        uvIndex            = 0.0
        visibility         = 0.0
        ozone              = 0.0
        apparentTemperature = 0.0

    }
        
    init?(dictionary: NSDictionary) {
        let date = Date(timeIntervalSince1970: dictionary[WeatherConstant.time] as! TimeInterval)
        self.time                   = Date().converUnixTimeToDate(date: date)
        self.summary                = dictionary[WeatherConstant.summary] as! String
        self.icon                   = dictionary[WeatherConstant.icon] as! String
        self.precipIntensity        = dictionary[WeatherConstant.precipIntensity] as! NSNumber
        self.precipProbability      = dictionary[WeatherConstant.precipProbability] as! NSNumber
        self.temperature            = dictionary[WeatherConstant.temperature] as! Double
        self.dewPoint = (dictionary[WeatherConstant.dewPoint] == nil || dictionary[WeatherConstant.dewPoint] is NSNull) ? 0.00 : dictionary[WeatherConstant.dewPoint] as? Double
        
        self.humidity = (dictionary[WeatherConstant.humidity] == nil || dictionary[WeatherConstant.humidity] is NSNull) ? 0.00 : dictionary[WeatherConstant.humidity] as? Double

        self.pressure = (dictionary[WeatherConstant.pressure] == nil || dictionary[WeatherConstant.pressure] is NSNull) ? 0.00 : dictionary[WeatherConstant.pressure] as? Double
        
        self.windSpeed = (dictionary[WeatherConstant.windSpeed] == nil || dictionary[WeatherConstant.windSpeed] is NSNull) ? 0.00 : dictionary[WeatherConstant.windSpeed] as? Double
        
        self.self.windGust = (dictionary[WeatherConstant.self.windGust] == nil || dictionary[WeatherConstant.self.windGust] is NSNull) ? 0.00 : dictionary[WeatherConstant.self.windGust] as? Double
        
        self.windBearing = (dictionary[WeatherConstant.windBearing] == nil || dictionary[WeatherConstant.windBearing] is NSNull) ? 0.00 : dictionary[WeatherConstant.windBearing] as? Double
       
        self.cloudCover = (dictionary[WeatherConstant.cloudCover] == nil || dictionary[WeatherConstant.cloudCover] is NSNull) ? 0.00 : dictionary[WeatherConstant.cloudCover] as? Double
        
        self.uvIndex = (dictionary[WeatherConstant.uvIndex] == nil || dictionary[WeatherConstant.uvIndex] is NSNull) ? 0.00 : dictionary[WeatherConstant.uvIndex] as? Double
       
        self.ozone = (dictionary[WeatherConstant.ozone] == nil || dictionary[WeatherConstant.ozone] is NSNull) ? 0.00 : dictionary[WeatherConstant.ozone] as? Double
    
        self.visibility = (dictionary[WeatherConstant.visibility] == nil || dictionary[WeatherConstant.visibility] is NSNull) ? 0.00 : dictionary[WeatherConstant.visibility] as? Double
        
        self.apparentTemperature = (dictionary[WeatherConstant.apparentTemperature] == nil || dictionary[WeatherConstant.apparentTemperature] is NSNull) ? 0.00 : dictionary[WeatherConstant.apparentTemperature] as? Double
    }
    
    
    

}
