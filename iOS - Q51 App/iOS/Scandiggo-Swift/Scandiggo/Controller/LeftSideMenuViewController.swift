//
//  LeftSideMenuViewController.swift
//  Scandiggo
//
//  Created by WTS on 29/01/16.
//  Copyright © 2016 wings. All rights reserved.
//

import UIKit

class LeftSideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let aryData = [["Icon" : "Home", "Name" : "My Cards"], ["Icon" : "Terms", "Name" : "Terms"], ["Icon" : "PrivacyPolicy", "Name" : "Privacy Policy"], ["Icon" : "Share", "Name" : "Share"], ["Icon" : "Setting", "Name" : "Setting"],  ["Icon" : "Logout", "Name" : "Logout"]]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryData.count
    }
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SideMenuCell", forIndexPath: indexPath) as! SideMenuCell
        let dic  = aryData[indexPath.row] as Dictionary
        cell.lblName.text = dic["Name"]
        cell.icon.image = UIImage(named: dic["Icon"]!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let appdele : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        switch indexPath.row {
        case 0:
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let terms = mainStoryboard.instantiateViewControllerWithIdentifier ("MyCardViewController") as! MyCardViewController
            let navTerms = UINavigationController(rootViewController: terms)
            self.mm_drawerController .setCenterViewController(navTerms, withCloseAnimation: true, completion: nil)
        case 1:
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let terms = mainStoryboard.instantiateViewControllerWithIdentifier ("TermsViewController") as! TermsViewController
            let navTerms = UINavigationController(rootViewController: terms)
            self.mm_drawerController.setCenterViewController(navTerms, withCloseAnimation: true, completion: nil)
        case 3:
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let terms = mainStoryboard.instantiateViewControllerWithIdentifier ("ShareViewController") as! ShareViewController
            let navTerms = UINavigationController(rootViewController: terms)
            self.mm_drawerController.setCenterViewController(navTerms, withCloseAnimation: true, completion: nil)
        case 4:
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let terms = mainStoryboard.instantiateViewControllerWithIdentifier ("SettingViewController") as! SettingViewController
            let navTerms = UINavigationController(rootViewController: terms)
            self.mm_drawerController.setCenterViewController(navTerms, withCloseAnimation: true, completion: nil)
        case 5:
            self.mm_drawerController.closeDrawerAnimated(true, completion: nil)
            appdele.logout()
            
        default:
            print("default")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
