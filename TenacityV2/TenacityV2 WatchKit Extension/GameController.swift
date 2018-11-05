//
//  InterfaceController.swift
//  Tenacity_Watch Extension
//
//  Created by PLL on 7/26/18.
//  Copyright © 2018 PLL. All rights reserved.
//

import WatchKit
import Foundation

//ALL DATA THAT MUST BE USED OUTSIDE OF THE CURRENT SCENE MUST BE PUT HERE
var seconds = 60
var seshGroups = [Int:[String:Any]] ()
var cycleCount: Int = 0
var device = WKInterfaceDevice.current()

class GameController: WKInterfaceController {
    
    var seshbegin = true
    var seshend = false
    var hapticCount: Int = 5
    var tapCount = 0
    var cycleTapCount = 0 //Logic breaks if a early swipe is performed, to fix this I made a cycle tap count that is compared against haptic count and resets each cycle
    
    var current_cycle: [String] = []
    var current_ts: [Date] = []
    
    @IBOutlet var EndSessionButton: WKInterfaceButton!
    
    @IBAction func EndSession() {
        seshend = true
        EndSessionButton.setEnabled(false)
        EndSessionButton.setHidden(true)
        ReHome.setEnabled(true)
        ReHome.setHidden(false)
        myLabel.setHidden(false)
        animebutton.setHidden(true)
        myLabel.setText("Cycles: \(cycleCount) \n Session Accuracy: \(getSeshAccuracy(dictionary: seshGroups))")
    }
    
    
    var timer = Timer()
    
    @IBOutlet var timerLabel: WKInterfaceLabel!
    
    @IBOutlet var ReHome: WKInterfaceButton!
    
    @IBAction func ReturnHome() {
        self.popToRootController()
    }
    @IBOutlet var timerSlider: WKInterfaceSlider!
    @IBAction func timerSlider(_ value: Float) {
        seconds = Int(value)
        timerLabel.setText(String(seconds))
        print(seconds)
    }
    
    //@IBOutlet var StartSeshButton: WKInterfaceButton!
    //@IBAction func StartSeshButton(_sender: Any) {
    //  StartSessionTimer()
    //}
    
    
    @objc func counter(){
        seconds -= 1
        print(seconds)
        if (seconds == 0){
            timer.invalidate()
        }
    }
    
    func StartSessionTimer(){
        if (tapCount == 0){
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (GameController.counter), userInfo: nil, repeats: true)
        }
    }
    
    
    //Gets session accuracy and returns it as a string. Needs to be improved so that it shows a percent and not a decimal
    func getSeshAccuracy(dictionary:[Int:[String:Any]]) -> String {
        var total: Float = 0
        var true_total: Float = 0
        for (_,dict) in dictionary {
            for (dataType, data) in dict{
                if dataType == "ToF" && isEqual(type: Bool.self, a: data, b: true) == true{
                    true_total+=1
                }
            }
            total+=1
        }
        print(total)
        print(true_total)
        return String(Double(true_total/total*100)) + "%"
    }
    
    // This function is used to compare Any variable types as swift will not let you use the == comparison if a var is declared as Any
    func isEqual<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool? {
        guard let a = a as? T, let b = b as? T else { return nil }
        
        return a == b
    }
    
    func animatebutton(count: Int) -> Void {
//        for i in 0...hapticCount {
//            if count == i {
//                animebutton.setWidth(76+CGFloat(i*5))
//                animebutton.setHeight(76+CGFloat(i*5))
//                animebutton.setCornerRadius(39+CGFloat(i*5))
//            }
//        }
        if count%2 == 0{
            animebutton.setWidth(76)
            animebutton.setHeight(76)
            animebutton.setCornerRadius(39)
        }
        else{
            animebutton.setWidth(150)
            animebutton.setHeight(150)
            animebutton.setCornerRadius(76.97)
        }
    }
    
    func tap() -> Void {
        if(seshend){
            return
        }
        if(seshbegin){
            animatebutton(count: cycleTapCount)
            seshbegin = false
            myLabel.setHidden(true)
            animebutton.setHidden(false)
        }
        StartSessionTimer()
        current_ts.append(Date())
        tapCount+=1
        cycleTapCount+=1
        animatebutton(count: cycleTapCount)
        myLabel.setText(String(tapCount))
        current_cycle.append("T")
        hapticCallerTap()
    }
    
    func swipes() -> Void{
        if(seshend){
            return
        }
        if(seshbegin){
            animatebutton(count: cycleTapCount)
            seshbegin = false
            myLabel.setHidden(true)
            animebutton.setHidden(false)
        }
        current_ts.append(Date())
        tapCount+=1
        cycleTapCount+=1
        animatebutton(count: cycleTapCount)
        myLabel.setText(String(tapCount))
        current_cycle.append("S")
        hapticCallerSwipe()
    }
    
    @IBAction func buttontap(_ sender: WKTapGestureRecognizer) {
        tap()
    }
    
    @IBAction func buttonswipe(_ sender: WKSwipeGestureRecognizer) {
        swipes()
    }
    
    @IBOutlet var animebutton: WKInterfaceGroup!
    
    @IBOutlet var myLabel: WKInterfaceLabel!
    
    @IBOutlet var screenTapp: WKTapGestureRecognizer!
    
    @IBAction func screenTap(_ sender: WKTapGestureRecognizer) {
        tap()
        
    }
    
    @IBOutlet var swipe: WKSwipeGestureRecognizer!
    
    @IBAction func swipe(_ sender2: WKSwipeGestureRecognizer) {
        swipes()
    }
    
    func success() {
        cycleCount+=1
        WKInterfaceDevice.current().play(.success)
        seshGroups[cycleCount] = ["cycleInputs":current_cycle,"timeStamps":current_ts,"ToF":true]
        current_cycle.removeAll()
        current_ts.removeAll()
        cycleTapCount = 0
        animatebutton(count: cycleTapCount)
        print(seshGroups)
        print(getSeshAccuracy(dictionary: seshGroups))
    }
    
    func fail(){
        cycleCount+=1
        WKInterfaceDevice.current().play(.failure)
        seshGroups[cycleCount] = ["cycleInputs":current_cycle,"timeStamps":current_ts,"ToF":false]
        current_cycle.removeAll()
        current_ts.removeAll()
        cycleTapCount = 0
        animatebutton(count: cycleTapCount)
        print(seshGroups)
        print(getSeshAccuracy(dictionary: seshGroups))
    }
    
    func hapticCallerTap() {
        if (cycleTapCount % hapticCount == 0){
            fail()
        }
    }
    func hapticCallerSwipe() {
        if (cycleTapCount % hapticCount == 0){
            success()
        }
        else{
            fail()
        }
    }
    
    //    override func awake(withContext context: Any?) {
    //        super.awake(withContext: context)
    //        // Configure interface objects here.
    //    }
    //
    //    override func willActivate() {
    //        // This method is called when watch view controller is about to be visible to user
    //        super.willActivate()
    //    }
    //
    //    override func didDeactivate() {
    //        // This method is called when watch view controller is no longer visible
    //        super.didDeactivate()
    //    }
    
    
}