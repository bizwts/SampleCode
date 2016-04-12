//
//  Themes.swift
//  Scandiggo
//
//  Created by WTS on 28/01/16.
//  Copyright © 2016 wings. All rights reserved.
//

import UIKit
//rgba(21, 56, 72, 1) 153848
let DarkGreenColor = UIColor(colorLiteralRed: 0.082, green: 0.219, blue: 0.282, alpha: 1)
//rgba(24, 51, 69, 1)
let NavigaionColor = UIColor(colorLiteralRed: 0.094, green: 0.200, blue: 0.270, alpha: 1)

// text color
//102632


extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor)
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, forState: forState)
    }}