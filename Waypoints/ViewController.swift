//
//  ViewController.swift
//  Waypoints
//
//  Created by Jaf Crisologo on 2016-12-27.
//  Copyright © 2016 Modium Design. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var meterLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var mileLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let meterThreshold = LocationTracker(threshold: 10.0)
    let kmThreshold = LocationTracker(threshold: 1000.0)
    let mileThreshold = LocationTracker(threshold: 1609.4)
    
    var kmWaypoints = [String]()
    var mileWaypoints = [String]()
    var testArray = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLocationLabel(withText: "Unknown")

        meterThreshold.addLocationChangeObserver { (result) -> () in
            switch result {
            case .success(let location):
                let coordinate = location.physical.coordinate
                let locationString = "\(coordinate.latitude), \(coordinate.longitude)"
                self.updateLocationLabel(withText: locationString)
                self.testArray.append(locationString)
            case .failure:
                self.updateLocationLabel(withText: "Failure")
            }
        }

        kmThreshold.addLocationChangeObserver { (result) -> () in
            switch result {
            case .success(let location):
                let coordinate = location.physical.coordinate
                let locationString = "\(coordinate.latitude), \(coordinate.longitude)"
                self.updateKMLabel(withText: locationString)
//                self.kmWaypoints.append(locationString)
//                self.testArray.append(locationString) // Test appending locations to array
            case .failure:
                self.updateKMLabel(withText: "Failure")
            }
        }

        mileThreshold.addLocationChangeObserver { (result) -> () in
            switch result {
            case .success(let location):
                let coordinate = location.physical.coordinate
                let locationString = "\(coordinate.latitude), \(coordinate.longitude)"
                self.updateMileLabel(withText: locationString)
//                self.mileWaypoints.append(locationString)
            case .failure:
                self.updateMileLabel(withText: "Failure")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coordinateCell", for: indexPath as IndexPath)
        cell.textLabel?.text = testArray[indexPath.row]
        return cell
    }
    
    @IBAction func reloadTable(_ sender: AnyObject) {
        self.tableView.reloadData()
        for coordinates in testArray {
            print(coordinates)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateLocationLabel(withText text: String) -> Void {
        meterLabel.text = "Location: \(text)"
    }

    func updateKMLabel(withText text: String) -> Void {
        kmLabel.text = "Location: \(text)"
    }

    func updateMileLabel(withText text: String) -> Void {
        mileLabel.text = "Location: \(text)"
    }
}
