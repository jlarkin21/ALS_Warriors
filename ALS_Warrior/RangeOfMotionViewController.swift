//
//  RangeOfMotionViewController.swift
//  ALS_Warrior
//
//  Created by Justin Larkin on 3/6/17.
//  Copyright © 2017 Justin Larkin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreMotion

class RangeOfMotionViewController: UIViewController {
    
    
    
    //Instance Variables
    
    var currentMaxAccelX: Double = 0.0
    var currentMaxAccelY: Double = 0.0
    var currentMaxAccelZ: Double = 0.0
    
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    
    var movementManager = CMMotionManager()
    
    //Outlets
    
    
    @IBOutlet var accX: UILabel!
    @IBOutlet var accY: UILabel!
    @IBOutlet var accZ: UILabel!
    @IBOutlet var maxAccX: UILabel!
    @IBOutlet var maxAccY: UILabel!
    @IBOutlet var maxAccZ: UILabel!
    
    @IBOutlet var rotX: UILabel!
    @IBOutlet var maxRotX: UILabel!
    @IBOutlet var rotY: UILabel!
    @IBOutlet var maxRotY: UILabel!
    @IBOutlet var rotZ: UILabel!
    @IBOutlet var maxRotZ: UILabel!

    
    
    @IBAction func resetValues(_ sender: UIButton) {
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
    }
    
    
    override func viewDidLoad() {
        
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
        
        movementManager.gyroUpdateInterval = 0.2
        movementManager.accelerometerUpdateInterval = 0.2
        movementManager.deviceMotionUpdateInterval = 0.2
        
        //Start Recording Data
        
        movementManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.outputAccData(acceleration: accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
 
        
        //        movementManager.startGyroUpdates(to: OperationQueue.current!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
        //            self.outputRotData(rotation: gyroData!.rotationRate)
        //            if (NSError != nil){
        //                print("\(NSError)")
        //            }
        //
        //
        //        })
        
        if movementManager.isDeviceMotionAvailable {
            movementManager.deviceMotionUpdateInterval = 0.02
            movementManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (deviceMotionData: CMDeviceMotion?, NSError) -> Void in
                self.outputDeviceData(deviceMotion: deviceMotionData!)
                if(NSError != nil){
                    print("\(NSError)")
                }
            })
        }
        
        
        
    }
        
        
        func outputDeviceData(deviceMotion: CMDeviceMotion){
            
            accX?.text = "\(deviceMotion.userAcceleration.x).2fg"
            if fabs(deviceMotion.userAcceleration.x) > fabs(currentMaxAccelX)
            {
                currentMaxAccelX = deviceMotion.userAcceleration.x
            }
            
            accY?.text = "\(deviceMotion.userAcceleration.y).2fg"
            if fabs(deviceMotion.userAcceleration.y) > fabs(currentMaxAccelY)
            {
                currentMaxAccelY = deviceMotion.userAcceleration.y
            }
            
            accZ?.text = "\(deviceMotion.userAcceleration.z).2fg"
            if fabs(deviceMotion.userAcceleration.z) > fabs(currentMaxAccelZ)
            {
                currentMaxAccelZ = deviceMotion.userAcceleration.z
            }
            
            
            maxAccX?.text = "\(currentMaxAccelX).2f"
            maxAccY?.text = "\(currentMaxAccelY).2f"
            maxAccZ?.text = "\(currentMaxAccelZ).2f"
            

            
            rotX?.text = "\(deviceMotion.attitude.pitch).2fg"
            if fabs(deviceMotion.attitude.pitch) > fabs(currentMaxRotX){
                currentMaxRotX = deviceMotion.attitude.pitch * (180/M_PI)
            }
            
            maxRotX?.text = "\(currentMaxRotX).2f"
            
            
            rotY?.text = "\(deviceMotion.attitude.roll).2fg"
            if fabs(deviceMotion.attitude.roll) > fabs(currentMaxRotY){
                currentMaxRotY = deviceMotion.attitude.roll * (180/M_PI)
            }
            
            maxRotY?.text = "\(currentMaxRotY).2f"
            
            rotZ?.text = "\(deviceMotion.attitude.yaw).2fg"
            if fabs(deviceMotion.attitude.yaw) > fabs(currentMaxRotZ){
                currentMaxRotZ = deviceMotion.attitude.yaw * (180/M_PI)
            }
            
            maxRotZ?.text = "\(currentMaxRotZ).2f"
            
            
        }

    
    func outputAccData(acceleration: CMAcceleration){
        
        accX?.text = "\(acceleration.x).2fg"
        if fabs(acceleration.x) > fabs(currentMaxAccelX)
        {
            currentMaxAccelX = acceleration.x
        }
        
        accY?.text = "\(acceleration.y).2fg"
        if fabs(acceleration.y) > fabs(currentMaxAccelY)
        {
            currentMaxAccelY = acceleration.y
        }
        
        accZ?.text = "\(acceleration.z).2fg"
        if fabs(acceleration.z) > fabs(currentMaxAccelZ)
        {
            currentMaxAccelZ = acceleration.z
        }
        
        
        maxAccX?.text = "\(currentMaxAccelX).2f"
        maxAccY?.text = "\(currentMaxAccelY).2f"
        maxAccZ?.text = "\(currentMaxAccelZ).2f"
 
        
    }
    
    //    func outputRotData(rotation: CMRotationRate){
    //
    //
    //        rotX?.text = "\(rotation.x).2fr/s"
    //        if fabs(rotation.x) > fabs(currentMaxRotX)
    //        {
    //            currentMaxRotX = rotation.x
    //        }
    //
    //        rotY?.text = "\(rotation.y).2fr/s"
    //        if fabs(rotation.y) > fabs(currentMaxRotY)
    //        {
    //            currentMaxRotY = rotation.y
    //        }
    //
    //        rotZ?.text = "\(rotation.z).2fr/s"
    //        if fabs(rotation.z) > fabs(currentMaxRotZ)
    //        {
    //            currentMaxRotZ = rotation.z
    //        }
    //
    //
    //
    //
    //        maxRotX?.text = "\(currentMaxRotX).2f"
    //        maxRotY?.text = "\(currentMaxRotY).2f"
    //        maxRotZ?.text = "\(currentMaxRotZ).2f"
    //
    //
    //
    //    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
