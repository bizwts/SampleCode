//
//  PrivacyPolicyViewController.swift
//  Scandiggo
//
//  Created by WTS on 28/01/16.
//  Copyright © 2016 wings. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    @IBAction func privacyPolicyClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        NSNotificationCenter.defaultCenter().postNotificationName("AcceptPrivacyPolicy", object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
