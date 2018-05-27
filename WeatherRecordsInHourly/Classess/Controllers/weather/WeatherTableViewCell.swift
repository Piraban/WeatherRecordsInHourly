//
//  WeatherTableViewCell.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    private var weather: Weather!

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func configureWeatherCell(_ weather: Weather){
        self.lblDateTime.text = weather.time
        self.lblDescription.text = weather.summary
        switch weather.icon {
            case WeatherType.clearDay.rawValue:
                self.weatherImg.image  = UIImage(named: "clearday")
            case WeatherType.clearNight.rawValue:
                self.weatherImg.image = UIImage(named: "clearnight")
            case WeatherType.rain.rawValue:
                self.weatherImg.image = UIImage(named: "rain")
            case WeatherType.snow.rawValue:
                self.weatherImg.image  = UIImage(named: "snow")
            case WeatherType.wind.rawValue:
                self.weatherImg.image  = UIImage(named: "wind")
            case WeatherType.cloudy.rawValue:
                self.weatherImg.image  = UIImage(named: "cloudy")
            case WeatherType.partlyCloudyDay.rawValue:
                self.weatherImg.image  = UIImage(named: "partlycloudyday")
            case WeatherType.partlyCloudyNight.rawValue:
                self.weatherImg.image  = UIImage(named: "partlycloudynight")
           
            default:
                self.weatherImg.image  = UIImage(named: "clearday")
        }
    }
}
