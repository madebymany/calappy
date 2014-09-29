//
//  MXMRoomSelectViewController.h
//  Calappy
//
//  Created by Dan Brown on 02/04/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXMRoomCalendarViewController.h"
#import "MXMGoogleManager.h"

@interface MXMRoomSelectViewController : UITableViewController

@property NSArray *calendarNames;
@property NSArray *calendarIds;
@property (nonatomic) NSString *savedCalendarId;

@end
