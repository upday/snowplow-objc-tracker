//
//  ViewController.swift
//  SnowplowSwiftDemo
//
//  Created by Michael Hadam on 1/17/18.
//  Copyright © 2018 snowplowanalytics. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import SnowplowTracker

// Used for all child views
protocol PageObserver: class {
    func getParentPageViewController(parentRef: PageViewController)
}

class DemoViewController: UIViewController, UITextFieldDelegate, PageObserver {
    @IBOutlet weak var uriField: UITextField!
    @IBOutlet weak var trackingSwitch: UISegmentedControl!
    @IBOutlet weak var protocolSwitch: UISegmentedControl!
    @IBOutlet weak var methodSwitch: UISegmentedControl!
    @IBOutlet weak var screenSwitch: UISegmentedControl!
    
    var parentPageViewController: PageViewController!
    @objc dynamic var snowplowId: String! = "demo view"
    let tracker: Analytics = Analytics.sharedInstance

    func getParentPageViewController(parentRef: PageViewController) {
        parentPageViewController = parentRef
    }

    @objc func action() {
        let tracker = Analytics.getTracker()
        let tracking: Bool = (trackingSwitch.selectedSegmentIndex == 0)
        if (tracking && !(tracker?.getIsTracking() ?? false)) {
            tracker?.resumeEventTracking()
        } else if (tracker?.getIsTracking() ?? false) {
            tracker?.pauseEventTracking()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Analytics.getEmitter()?.setUrlEndpoint(uriField.text!)
        return textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uriField.delegate = self
        self.trackingSwitch.addTarget(self, action: #selector(action), for: .valueChanged)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleScreen(_ sender: UISegmentedControl) {
        Analytics.getTracker()?.setAutotrackScreenViews(sender.selectedSegmentIndex == 0)
    }
    
    @IBAction func toggleMethod(_ sender: UISegmentedControl) {
        Analytics.updateMethod(methodType: (methodSwitch.selectedSegmentIndex == 0) ? .get : .post)
    }
    
    @IBAction func toggleProtocol(_ sender: UISegmentedControl) {
        Analytics.updateProtocol(protocolType: (protocolSwitch.selectedSegmentIndex == 0) ? .http: .https)
    }
    
    @IBAction func trackEvents(_ sender: UIButton) {
        DispatchQueue.global(qos: .default).async {
            DemoUtils.trackAll()
        }
    }
}
