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
    
    var currentMaxRotRateX: Double = 0.0
    
    
    var movementManager = CMMotionManager()
    
    var data: [CMDeviceMotion] = []
    var initialAttitude: CMAttitude = CMAttitude()
    
    
    //Outlets
    
    
    @IBOutlet var accX: UILabel!
    @IBOutlet var accY: UILabel!
   // @IBOutlet var accZ: UILabel!
    @IBOutlet var maxAccX: UILabel!
    @IBOutlet var maxAccY: UILabel!
   // @IBOutlet var maxAccZ: UILabel!
    
    @IBOutlet var rotX: UILabel!
    @IBOutlet var maxRotX: UILabel!
    @IBOutlet var rotY: UILabel!
    @IBOutlet var maxRotY: UILabel!
    @IBOutlet var rotZ: UILabel!
    @IBOutlet var maxRotZ: UILabel!
    
    @IBOutlet var rotRateX: UILabel!
    @IBOutlet var maxRotRateX: UILabel!
    
    @IBOutlet var initialRotX: UILabel!
    @IBOutlet var initialRotY: UILabel!
    @IBOutlet var initialRotZ: UILabel!
    
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
        
        let attitude = deviceMotion.attitude
        let pitchX = deviceMotion.attitude.pitch * (180/M_PI)
        let rollY = deviceMotion.attitude.roll * (180/M_PI)
        let yawZ = deviceMotion.attitude.yaw * (180/M_PI)
        let rotationRateX = deviceMotion.rotationRate.x * (180/M_PI)

        
        //if this is the first reading, set the initial attitude of the device
        
        if (data.count == 0) {
            initialAttitude = attitude
            initialRotX?.text = "\(pitchX).2fg"
            initialRotY?.text = "\(rollY).2fg"
            initialRotZ?.text = "\(yawZ).2fg"
            self.data.append(deviceMotion)

        }
        //else multiply the current reading by the inverse of the initial attitude at the beginning of the test (this will return the change in degrees from the starting position)
        else{
            
            attitude.multiply(byInverseOf: initialAttitude)
            
            //can append whole deviceMotion object or just the specific value we need
            self.data.append(deviceMotion)
            
            
            //Acceleration stuff(may not be needed)
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
            
            maxAccX?.text = "\(currentMaxAccelX).2f"
            maxAccY?.text = "\(currentMaxAccelY).2f"
            
            
            //X-Axis Rotation
            
            rotX?.text = "\(pitchX).2fg"
            if fabs(pitchX) > fabs(currentMaxRotX){
                currentMaxRotX = fabs(pitchX)
            }
            maxRotX?.text = "\(currentMaxRotX).2f"
            
            
            //Y-Axis Rotation
            
            rotY?.text = "\(rollY).2fg"
            if fabs(rollY) > fabs(currentMaxRotY){
                currentMaxRotY = fabs(rollY)
            }
            maxRotY?.text = "\(currentMaxRotY).2f"
            
            
            //Z-Axis Rotation
            
            rotZ?.text = "\(yawZ).2fg"
            if fabs(yawZ) > fabs(currentMaxRotZ){
                currentMaxRotZ = yawZ
            }
            maxRotZ?.text = "\(currentMaxRotZ).2f"
            
            
            //X-Axis Rotation Rate (degrees per second)
            
            rotRateX?.text = "\(rotationRateX).2fg"
            if fabs(rotationRateX) > fabs(currentMaxRotRateX){
                currentMaxRotRateX = fabs(rotationRateX)
            }
            maxRotRateX?.text = "\(currentMaxRotRateX).2f"
            

        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


