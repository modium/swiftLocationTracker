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
    
    let testBOL = "BOL-1016"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testArray.removeAll() // Remove all elements from array
        
        updateLocationLabel(withText: "Unknown")

        meterThreshold.addLocationChangeObserver { (result) -> () in
            switch result {
            case .success(let location):
                let coordinate = location.physical.coordinate
                let locationString = "\(coordinate.latitude), \(coordinate.longitude)"
                
                // Test function
                self.updateLocation(latitude: "\(coordinate.latitude)", longitude: "\(coordinate.longitude)", bolID: self.testBOL)
                
                self.updateLocationLabel(withText: locationString)
                self.testArray.append(locationString) // Test appending locations to array
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
                self.kmWaypoints.append(locationString)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "coordinateCell", for: indexPath) as! CoordinateCell
        cell.coordinateLbl.text = testArray[indexPath.row]
//        cell.coordinateLbl.text = kmWaypoints[indexPath.row]
        return cell
    }
    
    @IBAction func reloadTable(_ sender: AnyObject) {
        self.tableView.reloadData()
//        for coordinates in testArray {
//            print(coordinates)
//        }
    }
    
    @IBAction func clearCoordinates(_ sender: AnyObject) {
        testArray.removeAll()
        tableView.reloadData()
    }
    
    func updateLocation(latitude: String, longitude: String, bolID: String) {
        print("'lat': \(latitude), 'long': \(longitude), 'bol_id': \(bolID)")
    
//        let myUrl = NSURL(string: "http://dev.bulkdash.com/api/v1/bol/addLocation")
//        let request = NSMutableURLRequest(URL:myUrl!);
//        request.HTTPMethod = "POST";
//        
//        let postString = "email=\(userEmailAddress!)&password=\(userPassword!)";
//        
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
//        
//        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) in
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                
//                spinningActivity.hideAnimated(true)
//                
//                if(error != nil) {
//                    // Display alert message
//                    let myAlert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
//                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//                    myAlert.addAction(okAction)
//                    self.presentViewController(myAlert, animated: true, completion: nil)
//                    return
//                }
//                
//                do {
//                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
//                    
//                    if let parseJSON = json { // Try to unwrap JSON data
//                        
//                        let userId = parseJSON["userId"]
//                        
//                        if(userId != nil) {
//                            
//                            // DO NOT STORE PASSWORD
//                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userName"], forKey: "userName")
//                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["token"], forKey: "token")
//                            /* This is where we store the user's Id for app use */
//                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userId"], forKey: "userId")
//                            NSUserDefaults.standardUserDefaults().synchronize() // Store user data within app for later access
//                            
//                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                            appDelegate.buildNavigationDrawer()
//                            
//                        } else {
//                            
//                            // Display alert message
//                            let userMessage = parseJSON["error"] as? String
//                            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
//                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//                            myAlert.addAction(okAction)
//                            self.presentViewController(myAlert, animated: true, completion: nil)
//                            
//                        }
//                        
//                    }
//                } catch {
//                    print(error)
//                }
//                
//            }
//            
//        }).resume()
        
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
