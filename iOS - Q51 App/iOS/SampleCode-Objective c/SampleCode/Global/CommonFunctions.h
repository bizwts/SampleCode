//
//  CommonFunctions.h
//  GuruListen
//
//  Created by Wingstech Solutions Pvt. Ltd. on 05/11/14.
//  Copyright (c) 2014 WingsTechSolutions. All rights reserved.
//

BOOL REUIKitIsFlatMode(void)
{
    static BOOL isUIKitFlatMode = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (floor(NSFoundationVersionNumber) > 993.0) {
            // If your app is running in legacy mode, tintColor will be nil - else it must be set to some color.
            if (UIApplication.sharedApplication.keyWindow) {
                isUIKitFlatMode = [UIApplication.sharedApplication.delegate.window respondsToSelector:@selector(tintColor)];
            } else {
                // Possible that we're called early on (e.g. when used in a Storyboard). Adapt and use a temporary window.
                isUIKitFlatMode = [[UIWindow new] respondsToSelector:@selector(tintColor)];
            }
        }
    });
    return isUIKitFlatMode;
}

