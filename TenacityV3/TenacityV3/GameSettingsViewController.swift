//
//  GameSettingsViewController.swift
//  TenacityV3
//
//  Created by PLL on 7/30/19.
//  Copyright © 2019 PLL. All rights reserved.
//

import UIKit
import WatchConnectivity

class GameSettingsViewController: PhoneViewController{
    
    var breathePic = 0
    var breatheColor = 0
    var lotusPic = 0
    var lotusColor = 0
    
    @IBOutlet var breathePicLabels: [UILabel]!
    @IBOutlet var breatheColorLabels: [UILabel]!
    @IBOutlet var lotusPicLabels: [UILabel]!
    @IBOutlet var lotusColorLabels: [UILabel]!
    
    
    // changes the top font to white (time and battery life wifi etc)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // takes out top bar
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        testUserDefaults()
        updateLabelsOpen()
        
    }
    
    // --------------------------------------- BREATHE PICS -------------------------------------
    
    @IBAction func classic(_ sender: UIButton) {
        //sendData(theme: "classic", game: "breathe")
        saveToRealm(what: "breathe: equip classic theme")
        breathePic = sender.tag
        //sendMessage(type: "pic", game: "breathe", num: sender.tag)
        sendAppContext()
        self.updateLabels(group: self.breathePicLabels, num: sender.tag)
        
    }
    @IBAction func fire(_ sender: UIButton) {
        //sendData(theme: "fire", game: "breathe")
        saveToRealm(what: "breathe: equip fire theme")
        breathePic = sender.tag
        //sendMessage(type: "pic", game: "breathe", num: 1)
        sendAppContext()
        self.updateLabels(group: self.breathePicLabels, num: sender.tag)
    }
    @IBAction func cloud(_ sender: UIButton) {
        //sendData(theme: "cloud", game: "breathe")
        saveToRealm(what: "breathe: equip cloud theme")
        breathePic = sender.tag
        //sendMessage(type: "pic", game: "breathe", num: 2)
        sendAppContext()
        self.updateLabels(group: self.breathePicLabels, num: sender.tag)
    }
    @IBAction func diamond(_ sender: UIButton) {
        //sendData(theme: "diamond", game: "breathe")
        saveToRealm(what: "breathe: equip diamond theme")
        breathePic = sender.tag
        //sendMessage(type: "pic", game: "breathe", num: 3)
        sendAppContext()
        self.updateLabels(group: self.breathePicLabels, num: sender.tag)
    }
    
    // --------------------------------------- BREATHE COLORS -------------------------------------
    
    @IBAction func redB(_ sender: UIButton) {
        //sendData(theme: "", game: "breathe", color: 1)
        saveToRealm(what: "breathe: equip red color")
        breatheColor = sender.tag
        //sendMessage(type: "color", game: "breathe", num: 2)
        sendAppContext()
        self.updateLabels(group: self.breatheColorLabels, num: sender.tag)
    }
    @IBAction func blueB(_ sender: UIButton) {
        //sendData(theme: "", game: "breathe", color: 0)
        saveToRealm(what: "breathe: equip blue color")
        breatheColor = sender.tag
        //sendMessage(type: "color", game: "breathe", num: 0)
        sendAppContext()
        self.updateLabels(group: self.breatheColorLabels, num: sender.tag)
    }
    @IBAction func saffronB(_ sender: UIButton) {
        //sendData(theme: "", game: "breathe", color: 2)
        saveToRealm(what: "breathe: equip pink color")
        breatheColor = sender.tag
        //sendMessage(type: "color", game: "breathe", num: 1)
        sendAppContext()
        self.updateLabels(group: self.breatheColorLabels, num: sender.tag)
    }
    @IBAction func lavenderB(_ sender: UIButton) {
        //sendData(theme: "", game: "breathe", color: 3)
        saveToRealm(what: "breathe: equip green color")
        breatheColor = sender.tag
        //sendMessage(type: "color", game: "breathe", num: 3)
        sendAppContext()
        self.updateLabels(group: self.breatheColorLabels, num: sender.tag)
    }
    
    
    // --------------------------------------- LOTUS PICS -------------------------------------
    
    @IBAction func lotus(_ sender: UIButton) {
        //sendData(theme: "lotus", game: "lotus")
        saveToRealm(what: "lotus: equip lotus theme")
        lotusPic = sender.tag
        //sendMessage(type: "pic", game: "lotus", num: 0)
        sendAppContext()
        self.updateLabels(group: self.lotusPicLabels, num: sender.tag)
    }
    @IBAction func squares(_ sender: UIButton) {
        //sendData(theme: "square", game: "lotus")
        saveToRealm(what: "lotus: equip square theme")
        lotusPic = sender.tag
        //sendMessage(type: "pic", game: "lotus", num: 1)
        sendAppContext()
        self.updateLabels(group: self.lotusPicLabels, num: sender.tag)
    }
    @IBAction func heart(_ sender: UIButton) {
        //sendData(theme: "heart", game: "lotus")
        saveToRealm(what: "lotus: equip heart theme")
        lotusPic = sender.tag
        //sendMessage(type: "pic", game: "lotus", num: 2)
        sendAppContext()
        self.updateLabels(group: self.lotusPicLabels, num: sender.tag)
    }
    @IBAction func circle(_ sender: UIButton) {
        //sendData(theme: "circle", game: "lotus")
        saveToRealm(what: "lotus: equip circle theme")
        lotusPic = sender.tag
        //sendMessage(type: "pic", game: "lotus", num: 3)
        sendAppContext()
        self.updateLabels(group: self.lotusPicLabels, num: sender.tag)
    }
    
    // --------------------------------------- LOTUS COLORS -------------------------------------
    
    @IBAction func lotusOG(_ sender: UIButton) {
        //sendData(theme: "", game: "lotus", color: 0)
        saveToRealm(what: "lotus: equip lotus color")
        lotusColor = sender.tag
        //sendMessage(type: "color", game: "lotus", num: 0)
        sendAppContext()
        self.updateLabels(group: self.lotusColorLabels, num: sender.tag)
    }
    @IBAction func lotusForest(_ sender: UIButton) {
        //sendData(theme: "", game: "lotus", color: 1)
        saveToRealm(what: "lotus: equip forest color")
        lotusColor = sender.tag
        //sendMessage(type: "color", game: "lotus", num: 1)
        sendAppContext()
        self.updateLabels(group: self.lotusColorLabels, num: sender.tag)
    }
    @IBAction func lotusOutrun(_ sender: UIButton) {
        //sendData(theme: "", game: "lotus", color: 2)
        saveToRealm(what: "lotus: equip outrun color")
        lotusColor = sender.tag
        //sendMessage(type: "color", game: "lotus", num: 2)
        sendAppContext()
        self.updateLabels(group: self.lotusColorLabels, num: sender.tag)
    }
    @IBAction func lotusPool(_ sender: UIButton) {
        //sendData(theme: "", game: "lotus", color: 3)
        saveToRealm(what: "lotus: equip pool party color")
        lotusColor = sender.tag
        //sendMessage(type: "color", game: "lotus", num: 3)
        sendAppContext()
        self.updateLabels(group: self.lotusColorLabels, num: sender.tag)
    }
    
    // -----------------------------------------------------------------------------------------
    
    func sendData(theme : String, game : String, color : Int = -1){
        let session = WCSession.default
        if session.activationState == .activated{
            let data = ["theme": theme, "game": game, "color" : color] as [String : Any]
            session.transferUserInfo(data)
            
            print("sent")
        }
    }
    
    func sendAppContext(){
        let session = WCSession.default
        
        if session.activationState == .activated {
            
            let data = ["lpic": lotusPic, "lcol": lotusColor, "bpic": breathePic, "bcol": breatheColor]
            
            do {
                try session.updateApplicationContext(data)
            } catch {
                print("Alert! Updating app context failed")
            }
        }
    }
    
    func sendMessage(type : String, game : String, num : Int){
        let session = WCSession.default
        let data = ["type": type, "game": game, "num" : num] as [String : Any]
        session.sendMessage(data, replyHandler: {response in
            let game = response["game"] as! String
            let type = response["type"] as! String
            let x = response["num"] as! Int
            
            print("recieved " + game)
            
            if (game == "breathe"){
                if (type == "color"){
                    self.updateLabels(group: self.breatheColorLabels, num: x)
                    UserDefaults.standard.set(x, forKey: "breatheColor")
                }
                else if (type == "pic"){
                    self.updateLabels(group: self.breathePicLabels, num: x)
                    UserDefaults.standard.set(x, forKey: "breathePic")
                }
            }
            else if (game == "lotus"){
                if (type == "color"){
                    self.updateLabels(group: self.lotusColorLabels, num: x)
                    UserDefaults.standard.set(x, forKey: "lotusColor")
                }
                else if (type == "pic"){
                    self.updateLabels(group: self.lotusPicLabels, num: x)
                    UserDefaults.standard.set(x, forKey: "lotusPic")
                }
            }
        })
    }
    
    func updateLabels(group : Array<UILabel>, num : Int){
        DispatchQueue.main.async {
            for i in group{
                if i.tag != num{
                    i.isHidden = true
                }
                else{
                    i.text = "Equipped"
                    i.isHidden = false
                }
            }
        }
    }
    
    func updateLabelsOpen(){
        for i in breathePicLabels{
            if (i.tag == breathePic){
                i.isHidden = false
                i.text = "equipped"
            }
        }
        for i in breatheColorLabels{
            if (i.tag == breatheColor){
                i.isHidden = false
                i.text = "equipped"
            }
        }
        for i in lotusPicLabels{
            if (i.tag == lotusPic){
                i.isHidden = false
                i.text = "equipped"
            }
        }
        for i in lotusColorLabels{
            if (i.tag == lotusColor){
                i.isHidden = false
                i.text = "equipped"
            }
        }
    }
    
    override func testUserDefaults(){
        let defaults = UserDefaults.standard
        
        breathePic = defaults.integer(forKey: "breathePic")
        breatheColor = defaults.integer(forKey: "breatheColor")
        lotusPic = defaults.integer(forKey: "lotusPic")
        lotusColor = defaults.integer(forKey: "lotusColor")
    }
    
    
}
