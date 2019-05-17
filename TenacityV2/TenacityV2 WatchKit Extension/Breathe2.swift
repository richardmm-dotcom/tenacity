//
//  Breathe2.swift
//  TenacityV2
//
//  Created by PLL on 5/9/19.
//  Copyright © 2019 PLL. All rights reserved.
//


import WatchKit
import Foundation


class Breathe2Controller: WKInterfaceController {
    
    let startRelativeHeight = 0.45
    let startRelativeWidth = 0.5
    
    var counter = 0.0
    
    var averageFullBreatheTime = 3.5
    var totalBreaths = 0
    
    var breatheInTimer = Timer()
    var breatheInTime = 0.0
    
    var FullCycle = 5
    var cycleTotal = 0
    var cycleStep = 0
    
    @IBOutlet weak var image: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //image.setTintColor(UIColor.yellow)
        // Configure interface objects here.
        image.setImageNamed("breathey")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func forceQuit() {
    }
    
    @objc func breatheInCounter(){
        if (counter < averageFullBreatheTime){
            animate(withDuration: 0.1){
                //self.alpha = (self.counter/self.averageFullBreatheTime)
                //self.image.setAlpha(CGFloat(self.alpha))
                let addHeight = (1 - self.startRelativeWidth)*(self.counter/self.averageFullBreatheTime)
                let addWidth = (1 - self.startRelativeHeight)*(self.counter/self.averageFullBreatheTime)
                self.image.setRelativeWidth(CGFloat(self.startRelativeWidth + addWidth), withAdjustment: 0)
                self.image.setRelativeHeight(CGFloat(self.startRelativeWidth + addHeight), withAdjustment: 0)
                self.counter += 0.1
            }
        }
        WKInterfaceDevice.current().play(.directionUp)
        breatheInTime += 0.1
    }
    
    func resetImage(){
        self.image.setRelativeWidth(CGFloat(startRelativeWidth), withAdjustment: 0)
        self.image.setRelativeHeight(CGFloat(startRelativeHeight), withAdjustment: 0)
    }
    
    func cycleReset(){ //goes back to step one
        cycleStep = 0
        self.image.setImageNamed("breathey")
    }
    
    @IBAction func swipeAction(_ sender: Any) {
        if (cycleStep != FullCycle){
            let continueAlert = WKAlertAction(title: "Continue", style: .cancel){
            }
            presentAlert(withTitle: "Oops", message: "You Swiped When You Should Have Held", preferredStyle: .alert, actions: [continueAlert])
        }
        WKInterfaceDevice.current().play(.directionDown)
        cycleReset()
    }
    
    @IBAction func longPressHold(_ gestureRecognizer: WKLongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began{
            resetImage()
            counter = 0
            breatheInTime = 0
            breatheInTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector (InterfaceController.breatheInCounter), userInfo: nil, repeats: true)
            
            cycleStep += 1
        }
        else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled{
            breatheInTimer.invalidate()
            print("breathe in time: " + String(format: "%.3f", breatheInTime))
            totalBreaths += 1
            print("total breaths: " + String(totalBreaths))
            
            animate(withDuration: (breatheInTime - 1)){
                self.image.setRelativeWidth(CGFloat(self.startRelativeWidth), withAdjustment: 0)
                self.image.setRelativeHeight(CGFloat(self.startRelativeHeight), withAdjustment: 0)
            }
            if (cycleStep == (FullCycle + 1)){
                cycleReset()
                let continueAlert = WKAlertAction(title: "Continue", style: .cancel){
                }
                presentAlert(withTitle: "Oops", message: "You Held When You Should Have Swiped", preferredStyle: .alert, actions: [continueAlert])
            }
            else{
                self.image.setImageNamed("breathe")
            }
            
        }
        
    }
}