//
//  GTLCalendarEvent+MXMTableCells.h
//  Calappy
//
//  Created by Dan Brown on 31/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "GTLCalendarEvent.h"
#import "GTLCalendarEventDateTime.h"
#import "GTLCalendarEventAttendee.h"
#import "MXMCalendarEntryTableViewCell.h"
#import "UIColor+MXMCalendarColors.h"

static NSString *organizerEmailSuffix = @"@example.com";

@interface GTLCalendarEvent (MXMTableCells)

- (MXMCalendarEntryTableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
