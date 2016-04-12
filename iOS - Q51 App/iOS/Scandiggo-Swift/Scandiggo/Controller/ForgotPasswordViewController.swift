//
//  ForgotPasswordViewController.swift
//  Scandiggo
//
//  Created by WTS on 28/01/16.
//  Copyright © 2016 wings. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
    }

    @IBAction func forgotPasswordClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
