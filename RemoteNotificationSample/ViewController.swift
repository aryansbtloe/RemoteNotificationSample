//
//  ViewController.swift
//  RemoteNotificationSample
//
//  Created by Alok Singh on 11/08/17.
//  Skype           : alok.singh.confident
//  Phone/Whatsapp  : 8287757210
//  Email           : alok.singh.confident@gmail.com
//  Official Email  : alok.k.singh@orahi.com
//  Github          : https://github.com/aryansbtloe
//  LinkedIn        : https://in.linkedin.com/in/alok-kumar-singh-09141164
//  Facebook        : https://www.facebook.com/aryansbtloe
//  Stack OverFlow  : http://stackoverflow.com/users/911270/alok-singh
//  CocoaControls   : https://www.cocoacontrols.com/authors/aryansbtloe
//  Copyright (c) 2017 Orahi. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var deviceToken: UILabel!
    
    var fetchedLocations = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startUpInitialisations()
        registerForNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func startUpInitialisations(){
        tableView.register(UINib(nibName: "LocationInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationInfoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        restoreDataFromDisk()
        Lem().takePermission()
        updateUserInterfaceOfScreen()
    }
    
    func registerForNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.fetchCurrentLocationAndSaveAndDisplay), name: NSNotification.Name(rawValue: KNotificationRemoteNotificationReceived), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateUserInterfaceOfScreen), name: NSNotification.Name(rawValue: KNotificationDeviceTokenFetched), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.syncDataToDisk), name: NSNotification.Name(rawValue: KNotificationAppAboutToTerminate), object: nil)
    }
    
    func updateUserInterfaceOfScreen(){
        deviceToken.text = getDeviceToken()
        tableView.reloadData()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(ViewController.updateUserInterfaceOfScreen), object: nil)
        self.perform(#selector(ViewController.updateUserInterfaceOfScreen), with: nil, afterDelay: 5)
    }
    
    func fetchCurrentLocationAndSaveAndDisplay(){
        Lem().takePermission()
        Lem().fetchingCurrentLocationOnce { (location) in
            let locationInfo = [
                "lat":"\(location.coordinate.latitude)",
                "lon":"\(location.coordinate.longitude)",
                "date":"\(Date().toStringValue(df))"
            ]
            self.fetchedLocations.insert(locationInfo, at: 0)
            self.updateUserInterfaceOfScreen()
        }
    }
    
    func syncDataToDisk(){
        do {
            let data = try JSONSerialization.data(withJSONObject: self.fetchedLocations, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            ud.set(jsonString, forKey: "fetchedLocations")
            ud.synchronize()
        }
        catch{}
    }
    
    func restoreDataFromDisk(){
        if let jsonString = ud.object(forKey: "fetchedLocations") as? String {
            if let data = jsonString.data(using: String.Encoding.utf8){
                do {
                    let fetchedLocationArray =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    self.fetchedLocations = fetchedLocationArray as! [[String : String]]
                    updateUserInterfaceOfScreen()
                } catch {
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedLocations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = self.fetchedLocations[indexPath.row]
        let cell = tableView .dequeueReusableCell(withIdentifier: "LocationInfoTableViewCell") as!LocationInfoTableViewCell
        cell.latLongLabel?.text = "lat : \(info["lat"]!)\nlon : \(info["lon"]!)"
        cell.timeLabel?.text = Date(fromString: info["date"]!, format: df)?.timePassed()
        return cell
    }
    
    @IBAction fileprivate func onClickOfCopyDeviceToken() {
        UIPasteboard.general.string = getDeviceToken()
        let prompt = UIAlertController(title: "Device Token Copied !", message: "1: Terminate this application.\n2:Send silent notifications\n3:Observe Recorded location." , preferredStyle: UIAlertControllerStyle.alert)
        prompt.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.default, handler: nil))
        self.present(prompt, animated: true, completion: nil)
        print("DEVICE TOKEN : \(getDeviceToken())")
    }
    
    @IBAction fileprivate func onClickOfCopySilentNotificationJson() {
        UIPasteboard.general.string = "{\"aps\":{\"content-available\":1,}}"
        let prompt = UIAlertController(title: "Notification Json Copied !", message: "1: open http://pushtry.com\n2:add provided pem\n3:paste device token\n4:select json and paste copied content\n5:Remove \\ character from Json Payload" , preferredStyle: UIAlertControllerStyle.alert)
        prompt.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.default, handler: nil))
        self.present(prompt, animated: true, completion: nil)
        print("SILENT PUSH NOTIFICATION PAYLOAD JSON : {'aps':{'content-available':1,}}")
    }
    
}

