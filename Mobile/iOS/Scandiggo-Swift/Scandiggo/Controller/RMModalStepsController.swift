//
//  RMModalStepsController.swift
//  Scandiggo
//
//  Created by WTS on 30/01/16.
//  Copyright © 2016 wings. All rights reserved.
//
/*
self.stepsBar.hideCancelButton = YES;
}

#pragma mark - Actions
- (void)finishedAllSteps {
[self.navigationController popViewControllerAnimated:YES];
}

- (void)canceled {
[self.navigationController popViewControllerAnimated:YES];
}

*/

import UIKit


class RMModalStepsController: RMStepsController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepsBar.hideCancelButton = true
    }
    
    override func finishedAllSteps() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func canceled() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
