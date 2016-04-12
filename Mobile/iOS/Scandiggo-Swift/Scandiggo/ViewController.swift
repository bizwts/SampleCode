//
//  ViewController.swift
//  Scandiggo
//
//  Created by WTS on 28/01/16.
//  Copyright © 2016 wings. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,KeyboardUtilityDelegate {

    @IBAction func loginButtonClick(sender: AnyObject) {
        
        print("loginButtonClick")
        var appdele : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appdele.drawer.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        appdele.setMyCardNavigationView()
        
    }
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var btnPasswordHideShow: UIButton!
    
    
    @IBOutlet var btnPrivacyPolicy: UIButton!
    var textFields: [UITextField] {
        return [
            txtEmail,
            txtPassword,
        ]
    }
    
    lazy var keyboardUtility: KeyboardUtility = {
        return KeyboardUtility(delegate: self)
    }()
    @IBAction func passwordHideShowClick(sender: AnyObject) {
        
        if(txtPassword.secureTextEntry) {
            btnPasswordHideShow.setImage(UIImage(named: "PasswordShow"), forState: UIControlState.Normal)
            txtPassword.secureTextEntry = false
        }else {
            btnPasswordHideShow.setImage(UIImage(named: "PasswordHide"), forState: UIControlState.Normal)
            txtPassword.secureTextEntry = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        keyboardUtility.start()
        self.navigationController?.navigationBarHidden = true
        //If you are using KeyboardUtility with a scroll view, I recommend subclassing your UIScrollView element (inside the storyboard) to KBScrollView, which blocks some of the autoscrolling behavior
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtEmail.delegate = self
        txtPassword.delegate = self
        btnLogin.setBackgroundColor(DarkGreenColor, forState: UIControlState.Highlighted)
        btnRegister.setBackgroundColor(DarkGreenColor, forState: UIControlState.Highlighted)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "acceptPrivacyPolicy", name: "AcceptPrivacyPolicy", object: nil)
    }
    
    func acceptPrivacyPolicy() {
        print("acceptPrivacyPolicy")
        btnPrivacyPolicy.setImage(UIImage(named: "Check"), forState: UIControlState.Normal)
    }

    @available(iOS 2.0, *)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

