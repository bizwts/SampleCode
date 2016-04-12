//
//  MyCardViewController.swift
//  Scandiggo
//
//  Created by WTS on 28/01/16.
//  Copyright © 2016 wings. All rights reserved.
//

import UIKit

class MyCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func rightNavClick(sender: AnyObject) {
        print("rightNavClick")
    }
    @IBAction func leftNavClick(sender: AnyObject) {

        let appdele : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdele.drawer.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
