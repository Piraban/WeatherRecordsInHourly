//
//  ViewController.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD

class WeatherViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet var weatherViewModal: WeatherViewModal?
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var lblWeatherDesc: UILabel!
    @IBOutlet weak var lblTemprature: UILabel!
    @IBOutlet weak var cWeatheImg: UIImageView!
    
    // MARK:- UI components
    var loadingNotification = MBProgressHUD()
    static let cellIdentifier = "weatherCell"
    
    //  MARK:- System
    let locationManager = CLLocationManager()
    
    // MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //location permission
        self.locationManager.requestAlwaysAuthorization()
      
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Service Call
    func invokeServiceAPI() -> Void {
        if Reachability.isConnectedToNetwork() == true {
            self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.loadingNotification.mode = MBProgressHUDMode.indeterminate
            self.loadingNotification.label.text = GeneralUIConstants.progressLoading
            self.loadingNotification.show(animated: true)
            
            self.invokeWeatherData()

        } else {
           self.displayError(MessageStrings.networkErrorTitle)
        }
    }
    
    func invokeWeatherData(){
        self.weatherViewModal?.fetchListHourlyWeather() { (success, result, error) -> Void in
            if(success) {
                self.loadingNotification.hide(animated: true)
                if((self.weatherViewModal?.weatherArray.count)! > 0){
                   self.refreshTable()
                }
            } else {
                self.loadingNotification.hide(animated: true)
                self.displayError(MessageStrings.weatherListErrorMessage)
            }
        }
    }
    
    func refreshTable() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.weatherTableView.reloadData()
            self.setupUI()
        })
    }
    
    func setupUI(){
        if(weatherViewModal?.currentlyWeather != nil){
            
            switch weatherViewModal?.currentlyWeather.icon {
                case WeatherType.clearDay.rawValue:
                    cWeatheImg.image   = UIImage(named: "clearday")
                case WeatherType.clearNight.rawValue:
                    cWeatheImg.image  = UIImage(named: "clearnight")
                case WeatherType.rain.rawValue:
                    cWeatheImg.image  = UIImage(named: "rain")
                case WeatherType.snow.rawValue:
                    cWeatheImg.image   = UIImage(named: "snow")
                case WeatherType.wind.rawValue:
                    cWeatheImg.image   = UIImage(named: "wind")
                case WeatherType.cloudy.rawValue:
                    cWeatheImg.image   = UIImage(named: "cloudy")
                case WeatherType.partlyCloudyDay.rawValue:
                    cWeatheImg.image   = UIImage(named: "partlycloudyday")
                case WeatherType.partlyCloudyNight.rawValue:
                    cWeatheImg.image   = UIImage(named: "partlycloudynight")
                
                default:
                    cWeatheImg.image   = UIImage(named: "clearday")
            }
            
            if let tempVal = weatherViewModal?.currentlyWeather.temperature{
                lblTemprature.text = "\(String(describing: tempVal))"
            }else{
                lblTemprature.text = "0"
            }
            lblWeatherDesc.text = weatherViewModal?.currentlyWeather.summary
        }
    }
    
    func displayError(_ message: String){
        if self.view.viewWithTag(ErrorConstant.tag) == nil {
            let tapToRetry = Bundle.main.loadNibNamed(GeneralConstants.tapToRetryViewIdentifier, owner: self, options: nil)![0] as! TapToRetryView
            tapToRetry.lblMessage.text = message
            tapToRetry.frame = self.view.bounds
            tapToRetry.delegate = self as? TapToRetryDelegate
            tapToRetry.tag = ErrorConstant.tag
            self.view.addSubview(tapToRetry)
        }
    }
}

// MARK:- UITableViewDataSource
extension WeatherViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherViewModal!.weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherViewController.cellIdentifier, for: indexPath) as! WeatherTableViewCell
        cell.configureWeatherCell((self.weatherViewModal?.weatherArray[indexPath.row])!)
        return cell
    }
}

// MARK:- UITableViewDelegate
extension WeatherViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)
    }
}


// MARK:- CLLocationManagerDelegate
extension WeatherViewController :  CLLocationManagerDelegate {
    //Get the location, user accessing this app cordinate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if(weatherViewModal?.latitude != location.coordinate.latitude || weatherViewModal?.longitude != location.coordinate.longitude ){
                weatherViewModal?.latitude = location.coordinate.latitude
                weatherViewModal?.longitude = location.coordinate.longitude
                
                print(location.coordinate)
                self.invokeServiceAPI()
            }
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location access is denied.",
                                                message: "Have to show wheather. Please enable location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) in
            let noWeather = Bundle.main.loadNibNamed(GeneralConstants.noWeatherViewIdentifier, owner: self, options: nil)![0] as! UIView
            noWeather.frame = self.view.bounds
            self.view.addSubview(noWeather)
            
            })
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}

extension WeatherViewController: TapToRetryDelegate{
    func refresh() {
        let retryView = self.view.viewWithTag(ErrorConstant.tag)
        if retryView != nil{
            retryView?.removeFromSuperview()
        }
        self.invokeServiceAPI()
    }
}

