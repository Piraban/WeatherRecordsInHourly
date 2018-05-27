//
//  WeatherViewModal.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import Foundation

class WeatherViewModal: NSObject {
    var weatherArray: [Weather] = []
    var currentlyWeather: Weather = Weather()
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    //Mark:- fetch weeather list of data
    func fetchListHourlyWeather ( completion : @escaping (_ success:Bool, _ response:[Weather]?, _ error:NSError) -> Void) {
        
        let url = "forecast/\(Globals.sharedInstance.secretKey)/\(latitude),\(longitude)"
        let parameters: [String : AnyObject] = [:]
        let requestData: [String : AnyObject] = [WeatherRecordsInHourlyAPI.KEY_PARTIAL_URL  : url as AnyObject,
                                                 WeatherRecordsInHourlyAPI.KEY_PARAMETERS   : parameters as AnyObject]
        WeatherRecordsInHourlyAPI().get(requestData) { (success, response, error) -> Void in
            if success {
                let resultDict  = response as! NSDictionary
                //Hourly weather
                let hourlyItems = resultDict["hourly"] as! NSDictionary //Hourly Object
                let dataArray   = hourlyItems["data"] as! NSArray // Hourly Data array
                //Currently weather information
                self.currentlyWeather = Weather(dictionary: resultDict["currently"] as! NSDictionary)!
                
                if(dataArray.count > 0) {
                    for resultData in dataArray as [AnyObject] {
                        let weather : Weather = Weather(dictionary: resultData as! NSDictionary)!
                        self.weatherArray.append(weather)
                    }
                }
                completion(true, nil, error)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    
}
