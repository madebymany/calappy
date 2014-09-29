//
//  MXMGoogleManager.m
//  Calappy
//
//  Created by Dan Brown on 27/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "MXMGoogleManager.h"

static void addFreePeriods(NSDate *now, NSArray *events, NSMutableArray *out) {
    NSDate *endDate = now;
    GTLDateTime *startDate;
    NSDateComponents *duration;
    
    for (GTLCalendarEvent *event in events) {
        startDate = [[event start] dateTime];
        if ([endDate compare:[startDate date]] == NSOrderedAscending) {
            duration = [[startDate calendar] components:NSHourCalendarUnit|NSMinuteCalendarUnit
                                               fromDate:endDate
                                                 toDate:[startDate date]
                                                options:0];
            if (duration.minute > 2) {
                [out addObject:[[MXMFreePeriod alloc] initWithDateTime:endDate duration:duration]];
            }
        }
        
        [out addObject:event];
        endDate = [[[event end] dateTime] date];
    }
    
    if ([out count] == 0) {
        [out addObject:[[MXMFreePeriod alloc] initWithDateTime:endDate duration:nil]];
    } else {
        GTLCalendarEvent *lastEvent = (GTLCalendarEvent *)[out lastObject];
        NSDate *endDate = [[[lastEvent end] dateTime] date];
        NSDateComponents *endDateComponents = [[[lastEvent end] dateTime] dateComponents];
        NSUInteger endMinuteOfDay = (endDateComponents.hour * 60) + endDateComponents.minute;
        
        if (endMinuteOfDay < endOfDayMinuteOfDay) {
            [out addObject:[[MXMFreePeriod alloc] initWithDateTime:endDate duration:nil]];
        }
    }
}

@implementation MXMGoogleManager

- (MXMGoogleManager *) init
{
    self = [super init];
    if (self) {
        self.calendarService = [[GTLServiceCalendar alloc] init];
    }
    return self;
}

- (void)eventsForCalendarId:(NSString *)calendarId completionBlock:(void (^)(NSArray *events, NSError *error))onCompletion
{
    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsListWithCalendarId:calendarId];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *endDate, *startDate, *now = [NSDate date];
    startDate = now;
    
    NSDateComponents *displayInterval = [[NSDateComponents alloc] init];
    displayInterval.hour = hoursToDisplay;
    
    endDate = [calendar dateByAddingComponents:displayInterval toDate:startDate options:0];
    
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    
    query.timeMin = [GTLDateTime dateTimeWithDate:startDate timeZone:tz];
    query.timeMax = [GTLDateTime dateTimeWithDate:endDate timeZone:tz];
    query.orderBy = kGTLCalendarOrderByStartTime;
    query.singleEvents = YES;
    
    [self.calendarService executeQuery:query
                     completionHandler:^(GTLServiceTicket *ticket, GTLCalendarEvents *events, NSError *error) {
                         NSArray *eventsArr = [events items];
                         if (!error) {
                             NSMutableArray *eventsWithFreePeriods = [NSMutableArray array];
                             addFreePeriods(now, eventsArr, eventsWithFreePeriods);
                             eventsArr = [NSArray arrayWithArray:eventsWithFreePeriods];
                         }
                         onCompletion(eventsArr, error);
                     }];
}

- (void)setAuth:(GTMOAuth2Authentication *)newAuth
{
    _auth = newAuth;
    self.calendarService.authorizer = _auth;
    if (self.delegate) {
        [self.delegate googleManagerReadyForQuerying];
    }
}

- (GTMOAuth2ViewControllerTouch *) authViewController
{
    SEL const viewControllerFinishedSelector = sel_registerName("viewController:finishedWithAuth:error:");
    return [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeCalendarReadonly
                                                      clientID:clientId
                                                  clientSecret:clientSecret
                                              keychainItemName:keychainItemName
                                                      delegate:self
                                              finishedSelector:viewControllerFinishedSelector];
}

- (void)showAuthIfRequiredByPushingTo:(UINavigationController *)navController animated:(BOOL)animated
{
    GTMOAuth2Authentication *authFromKeychain = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:keychainItemName
                                                                                                      clientID:clientId
                                                                                                  clientSecret:clientSecret];
    if ([authFromKeychain canAuthorize]) {
        self.auth = authFromKeychain;
    } else {
        [navController pushViewController:[self authViewController] animated:animated];
    }
}

- (void) viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)newAuth error:(NSError *) error
{
    if (error == nil) {
        // Success
        self.auth = newAuth;
    } else {
        self.auth = nil;
        /*
        if ([error code] == kGTMOAuth2ErrorWindowClosed) {
            // Cancelled
        }
        */
        [[viewController navigationController] pushViewController:viewController animated:YES];
    }
}

@end
