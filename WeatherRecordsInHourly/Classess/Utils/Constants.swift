//
//  Constants.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import Foundation

struct Constants{
    
}

struct APIConstants {
    static let contentType          =   "contentType"
}

struct GeneralUIConstants {
    static let progressLoading      = "Loading..."
}

struct NotificationConstants {
    static let invokeNetworkService  =   "kInvokeNetworkServiceIdentifier"
}

struct WeatherConstant {
    static let time               = "time"
    static let summary            = "summary"
    static let icon               = "icon"
    static let precipIntensity    = "precipIntensity"
    static let precipProbability  = "precipProbability"
    static let temperature        = "temperature"
    static let dewPoint           = "dewPoint"
    static let humidity           = "humidity"
    static let pressure           = "pressure"
    static let windSpeed          = "windSpeed"
    static let windGust           = "windGust"
    static let windBearing        = "windBearing"
    static let cloudCover         = "cloudCover"
    static let uvIndex            = "uvIndex"
    static let visibility         = "visibility"
    static let ozone              = "ozone"
    static let apparentTemperature = "apparentTemperature"
}

struct ErrorConstant {
    static let tag = 91
}


struct GeneralConstants {
    static let noNetworkViewIdentifier  = "NoNetworkView"
    static let noWeatherViewIdentifier  = "NoWeatherView"
    static let tapToRetryViewIdentifier = "TapToRetryView"
}

struct MessageStrings{
    static let errorTitle                   = "Error"
    static let networkErrorTitle            = "Network Error"
    static let uploadErrorTitle             = "Upload Error"
    static let weatherListErrorMessage      = "There was an error loading weather."
    static let weatherNoNetworkErrorMessage = "Please connect to the internet to load weather."
}


enum WeatherType: String{
    case clearDay           = "clear-day"
    case clearNight         = "clear-night"
    case rain               = "rain"
    case snow               = "snow"
    case sleet              = "sleet"
    case wind               = "wind"
    case fog                = "fog"
    case cloudy             = "cloudy"
    case partlyCloudyDay    = "partly-cloudy-day"
    case partlyCloudyNight  = "partly-cloudy-night"
}


