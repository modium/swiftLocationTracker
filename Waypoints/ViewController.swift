//
//  ViewController.swift
//  Waypoints
//
//  Created by Jaf Crisologo on 2016-12-27.
//  Copyright © 2016 Modium Design. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var meterLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var mileLabel: UILabel!
    
    let meterThreshold = LocationTracker(threshold: 10.0)
    let kmThreshold = LocationTracker(threshold: 1000.0)
    let mileThreshold = LocationTracker(threshold: 1609.4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLocationLabel(withText: "Unknown")

        meterThreshold.addLocationChangeObserver { (result) -> () in
            switch result {
            case .success(let location):
                let coordinate = location.physical.coordinate
                let locationString = "\(coordinate.latitude), \(coordinate.longitude)"
                self.updateLocationLabel(withText: locationString)
            case .failure:
                self.updateLocationLabel(withText: "Failure")
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateLocationLabel(withText text: String) -> Void {
//        self.locationLabel.text = "Location: \(text)"
        meterLabel.text = "Location: \(text)"
        kmLabel.text = "Location: \(text)"
        mileLabel.text = "Location: \(text)"
    }    
}

