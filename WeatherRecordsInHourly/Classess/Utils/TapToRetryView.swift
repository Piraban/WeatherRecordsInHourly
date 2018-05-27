//
//  TapToRetryView.swift
//  WeatherRecordsInHourly
//
//  Created by NCS_Piraba on 26/5/18.
//  Copyright © 2018 Piraba. All rights reserved.
//

import Foundation
import UIKit

protocol TapToRetryDelegate {
    func refresh()
}

class TapToRetryView: UIView {
    
    @IBOutlet weak var lblMessage: UILabel!
    
    var delegate : TapToRetryDelegate? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() -> Void {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapped(){
        delegate?.refresh()
    }
    
}
