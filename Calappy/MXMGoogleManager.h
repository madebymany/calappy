//
//  MXMGoogleManager.h
//  Calappy
//
//  Created by Dan Brown on 27/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXMFreePeriod.h"
#import "MXMGoogleManagerDelegateProtocol.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLCalendar.h"

static NSString * const keychainItemName = @"Calappy: Google Calendar";
static NSString * const clientId = @"xxx";
static NSString * const clientSecret = @"yyy";

static NSString * const kNewGoogleAuthNotification = @"newAuth";

static NSString * const resourceOneCalendarName = @"Calendar One";
static NSString * const resourceOneCalendarId = @"example.com_1234abcd@resource.calendar.google.com";
static NSString * const resourceTwoCalendarName = @"Calendar Two";
static NSString * const resourceTwoCalendarId = @"example.com_5678abcd@resource.calendar.google.com";

static NSUInteger const hoursToDisplay = 12;
static NSUInteger const endOfDayHour = 18;
static NSUInteger const endOfDayMinute = 0;
static NSUInteger const endOfDayMinuteOfDay = (endOfDayHour * 60) + endOfDayMinute;


@interface MXMGoogleManager : NSObject

@property (nonatomic, weak) id <MXMGoogleManagerDelegateProtocol> delegate;
@property (nonatomic) GTMOAuth2Authentication * auth;
@property (nonatomic) GTLServiceCalendar *calendarService;

- (GTMOAuth2ViewControllerTouch *) authViewController;
- (void)showAuthIfRequiredByPushingTo:(UINavigationController *)navController animated:(BOOL)animated;
- (void)eventsForCalendarId:(NSString *)calendarId completionBlock:(void (^)(NSArray *events, NSError *error))onCompletion;

@end
