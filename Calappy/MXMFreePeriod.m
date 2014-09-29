//
//  MXMFreePeriod.m
//  Calappy
//
//  Created by Dan Brown on 31/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "MXMFreePeriod.h"

@implementation MXMFreePeriod

- (MXMFreePeriod *)initWithDateTime:(NSDate *)startTime duration:(NSDateComponents *)duration
{
    self = [super init];
    if (self) {
        self.startTime = startTime;
        self.duration = duration;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"startTime: %@, duration: %@", _startTime, _duration];
}

@end
