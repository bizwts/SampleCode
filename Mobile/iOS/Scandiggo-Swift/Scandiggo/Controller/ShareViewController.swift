//
//  ShareViewController.swift
//  Scandiggo
//
//  Created by WTS on 29/01/16.
//  Copyright © 2016 wings. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    @IBAction func leftNavClick(sender: AnyObject) {
        let appdele : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdele.drawer.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
}
