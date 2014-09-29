//
//  MXMAppDelegate.h
//  Calappy
//
//  Created by Dan Brown on 21/02/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMOAuth2Authentication.h"

@interface MXMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) NSTimer *idleTimerControlTimer;

@end
