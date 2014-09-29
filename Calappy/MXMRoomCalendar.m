//
//  MXMRoomCalendar.m
//  Calappy
//
//  Created by Dan Brown on 26/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "MXMRoomCalendar.h"

@implementation MXMRoomCalendar

- (MXMRoomCalendar *) initWithServiceCalendar:(GTLServiceCalendar *)newServiceCalendar calendarId:(NSString *)newCalendarId
{
    self = [super init];
    if (self) {
        self.serviceCalendar = newServiceCalendar;
        self.calendarId = newCalendarId;
    }
    
    return self;
}

@end
