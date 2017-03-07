//
//  TapTest.swift
//  ALS_Warrior
//
//  Created by Justin Larkin on 3/6/17.
//  Copyright © 2017 Justin Larkin. All rights reserved.
//

import UIKit

class TapTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Outlets and properties
    

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timesPressedLabel: UILabel!
    var timer = Timer() //make a timer variable, but do do anything yet
    let timeInterval:TimeInterval = 0.05
    let timerEnd:TimeInterval = 10.0
    var timeCount:TimeInterval = 0.0
    var tapCounter = 0
    var timesTapped = 0
    //MARK: - Actions



    @IBAction func startTimer(_ sender: UIButton) {
        if !timer.isValid{ //prevent more than one timer on the thread
            timerLabel.text = timeString(time: timeCount)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(TapTestViewController.timerDidEnd(timer:)), userInfo: tapCounter, repeats: false)
                }

    }
    @IBAction func tapped(_ sender: UIButton) {
        tapCounter += 1
    }
    @IBAction func stopTimer(_ sender: UIButton) {
        timerLabel.text = "Timer Stopped"
        timer.invalidate()
    }
    @IBAction func resetTimer(_ sender: UIButton) {
        timer.invalidate()
        resetTimeCount()
        timerLabel.text = timeString(time: timeCount)
    }
    
    //MARK: - Instance Methods
    func resetTimeCount(){
        timeCount = timerEnd
       
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60
        //let seconds = Int(time) % 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10.0))
    }
    
    func timerDidEnd(timer:Timer){
        timesTapped = (timer.userInfo as? Int)!
        timesPressedLabel.text = String(timesTapped)
        
        //timer that counts down
        timeCount = timeCount - timeInterval
        if timeCount <= 0 {  //test for target time reached.
            timerLabel.text = "Test Done!!"
            timer.invalidate()
        } else { //update the time on the clock if not reached
            timerLabel.text = timeString(time: timeCount)
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
