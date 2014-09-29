//
//  MXMRoomCalendarViewController.h
//  Calappy
//
//  Created by Dan Brown on 13/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXMGoogleManager.h"
#import "MXMCalendarEntryTableViewCell.h"

@interface MXMRoomCalendarViewController : UITableViewController <MXMGoogleManagerDelegateProtocol>

@property (nonatomic) NSMutableArray *events;
@property (nonatomic) MXMGoogleManager *googleManager;
@property (nonatomic) NSString *calendarId;
@property (nonatomic) NSTimer *clockRefreshTimer;
@property (nonatomic) NSTimer *eventRefreshTimer;
@property (nonatomic) BOOL hasAuth;
@property UILabel *clockLabel;

@end
