//
//  SecondViewController.swift
//  Scandiggo
//
//  Created by WTS on 28/01/16.
//  Copyright © 2016 wings. All rights reserved.
//rgba(18, 42, 56, 1)

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate,KeyboardUtilityDelegate {

    @IBOutlet var kbScrollview: KBScrollView!
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtEmailId: UITextField!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtContactNo: UITextField!
    @IBOutlet var btnLogin: UIButton!
    
    var textFields: [UITextField] {
        return [
            txtName,
            txtContactNo,
            txtEmailId,
            txtPassword,
            txtConfirmPassword,
        ]
    }
    
    lazy var keyboardUtility: KeyboardUtility = {
        return KeyboardUtility(delegate: self)
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        keyboardUtility.start()
        //If you are using KeyboardUtility with a scroll view, I recommend subclassing your UIScrollView element (inside the storyboard) to KBScrollView, which blocks some of the autoscrolling behavior
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.delegate = self
        txtEmailId.delegate = self
        
        txtContactNo.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        kbScrollview.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) - 40, CGRectGetMaxY(btnLogin.frame) + 50)
    }

    @IBAction func loginButtonClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let nextTage=textField.tag+1;
        // Try to find next responder
        let nextResponder=textField.superview?.viewWithTag(nextTage) as UIResponder!
        
        if (nextResponder != nil){
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        }
        else
        {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
