//
//  WeatherRecordsInHourlyAPI.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import Alamofire

enum HTTPCodes: NSInteger {
    case success                = 200
    case successCreated         = 201
    case noContent              = 204
    case badRequest             = 400
    case unauthorized           = 401
    case forbidden              = 403
    case notFound               = 404
    case internalServerError    = 500
    case badGateway             = 502
    case serviceUnavailable     = 503
}

class WeatherRecordsInHourlyAPI : NSObject{
    
    static let KEY_FULL_URL         = "FullURL"
    static let KEY_PARTIAL_URL      = "PartialURL"
    static let KEY_PARAMETERS       = "Parameters"
    static var BASE_URL: String     = "https://api.darksky.net/"
    
    
    /**
     Common gateway for all HTTP GET requests
     - parameter data: A Dictionary type includes Partial URL and other Parameters to be passed in Request Body
     - Returns: Success{Bool}, Response{JSON or Error}, Error
     */
    func get(_ data: [AnyHashable: Any], onCompletion: @escaping (_ success: Bool, _ response: AnyObject, _ error: NSError) -> Void) {
        
        var fullURL = ""
        var partialURL = ""
        let parameters  = data[WeatherRecordsInHourlyAPI.KEY_PARAMETERS] as! [String : AnyObject]
        var contantType : String = ""
        
        partialURL = data[WeatherRecordsInHourlyAPI.KEY_PARTIAL_URL] as! String

        contantType = Globals.sharedInstance.contentType
        fullURL     = "\(WeatherRecordsInHourlyAPI.BASE_URL)\(partialURL)"
        
        var requestHeaders : [String: String] = [:]
        requestHeaders = [
                APIConstants.contentType    :   contantType
        ]
        
        
        Alamofire.request(fullURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: requestHeaders)
            .responseJSON { response in
                print("REQUEST \(String(describing: response.request))")
                print("RESPONSE \(String(describing: response.response))")
                print("DATA \(String(describing: response.data))")
                print("RESULT \(response.result)")
                
                if (response.result.isSuccess) {
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                    let statusCode : NSInteger = (response.response?.statusCode)!
                    print("http.code: \(statusCode)")
                    
                    switch statusCode {
                    case HTTPCodes.success.rawValue:
                        print("Success")
                        let error: NSError = NSError(domain: "No Error", code: statusCode, userInfo: nil)
                        onCompletion(true, response.result.value! as AnyObject, error)
                    default:
                        print("Failure")
                        let error: NSError = NSError(domain: "Error", code: statusCode, userInfo: nil)
                        onCompletion(false, error, error)
                    }
                } else {
                    print("MyError1: \(String(describing: response.result.error?.localizedDescription))")
                    let error: NSError = NSError(domain: "Error", code: -1, userInfo: nil)
                    onCompletion(false, error, error)
                }
        }
    }
    
}

