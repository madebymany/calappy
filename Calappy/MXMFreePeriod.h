//
//  MXMFreePeriod.h
//  Calappy
//
//  Created by Dan Brown on 31/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXMFreePeriod.h"
#import "GTLCalendar.h"

@interface MXMFreePeriod : NSObject

@property NSDate *startTime;
@property NSDateComponents *duration;

- (MXMFreePeriod *)initWithDateTime:(NSDate *)startTime duration:(NSDateComponents *)duration;

@end
