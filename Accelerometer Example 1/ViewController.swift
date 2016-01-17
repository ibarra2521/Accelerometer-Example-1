//
//  ViewController.swift
//  Accelerometer Example 1
//
//  Created by Nivardo Ibarra on 1/13/16.
//  Copyright © 2016 Nivardo Ibarra. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var lblX: UILabel!
    @IBOutlet weak var lblY: UILabel!
    @IBOutlet weak var lblZ: UILabel!
    @IBOutlet weak var lblShake: UILabel!
    
    private let manager = CMMotionManager()
    private let queue = NSOperationQueue()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = 1.0 / 10.0
            manager.startAccelerometerUpdatesToQueue(queue, withHandler: {
                data, error in
                if error != nil {
                    self.manager.stopAccelerometerUpdates()
                }else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.lblX.text = "\(data!.acceleration.x)"
                        self.lblY.text = "\(data!.acceleration.y)"
                        self.lblZ.text = "\(data!.acceleration.z)"
                        
                        if (data!.acceleration.x > 1.6) ||
                            (data!.acceleration.y > 1.6) ||
                            (data!.acceleration.z > 1.6) {
                            self.lblShake.text = "Yes!!!"
                        }
                    })
                }
            })
        }else {
            print("Accelerometer Unavailable")
        }
    }

    
    @IBAction func clean() {
        self.lblShake.text = ""
    }

}

