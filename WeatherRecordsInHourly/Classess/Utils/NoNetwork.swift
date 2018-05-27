//
//  NoNetwork.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import Foundation
import UIKit

class NoNetwork: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    func setupUI() -> Void {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NoNetwork.recallNetworkService))
        self.addGestureRecognizer(tap)
    }
    
    @objc func recallNetworkService() -> Void {
        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationConstants.invokeNetworkService), object: nil)
    }
}
