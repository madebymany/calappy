//
//  MXMRoomCalendar.h
//  Calappy
//
//  Created by Dan Brown on 26/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLCalendar.h"

@interface MXMRoomCalendar : NSObject

@property GTLServiceCalendar * serviceCalendar;
@property NSString * calendarId;

- (MXMRoomCalendar *) initWithServiceCalendar:(GTLServiceCalendar *)serviceCalendar calendarId:(NSString *)calId;

@end
