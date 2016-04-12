//
//  Macro.swift
//  SwiftTestProject
//
//  Created by ketansmodha on 12/12/14.
//  Copyright (c) 2014 WingsTechSolutions. All rights reserved.
//

import Foundation
import UIKit

class Macro: NSObject {
    
    let MVDeviceIphone = "iPhone"
    let MVDeviceIpad = "iPad"
    let MVDeviceIpod = "iPod"
    let MVDeviceSimulator = "Simulator"
    let MVCurrentDevice = UIDevice.currentDevice()
    
   
    let MainScreen = UIScreen.mainScreen()

    let X: (CGRect) -> (CGFloat) = {(frame:CGRect) -> CGFloat in frame.origin.x }
    let Y: (CGRect) -> (CGFloat) = {(frame:CGRect) -> CGFloat in frame.origin.y }

    let WIDHT: (CGRect) -> (CGFloat) = {(frame:CGRect) -> CGFloat in frame.size.width}    
}
