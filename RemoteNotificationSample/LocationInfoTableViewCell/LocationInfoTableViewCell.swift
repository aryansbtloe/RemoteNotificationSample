//
//  LocationInfoTableViewCell.swift
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
import Foundation
import UIKit

class LocationInfoTableViewCell : UITableViewCell {
    
    @IBOutlet weak var latLongLabel : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startUpInitialisations()
        updateUserInterfaceOnScreen()
    }
    
    private func startUpInitialisations(){
        self.contentView.layoutIfNeeded()
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    private func updateUserInterfaceOnScreen(){
        
    }
}
