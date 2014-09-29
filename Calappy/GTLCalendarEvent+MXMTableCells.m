//
//  GTLCalendarEvent+MXMTableCells.m
//  Calappy
//
//  Created by Dan Brown on 31/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "GTLCalendarEvent+MXMTableCells.h"

@implementation GTLCalendarEvent (MXMTableCells)

- (MXMCalendarEntryTableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"meeting";
    
    MXMCalendarEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                          forIndexPath:indexPath];
    
    cell.clockLabel.text = [MXMCalendarEntryTableViewCell formattedTimeForDate:[[self.start dateTime] date]];
    
    NSString *organizerName;
    if ([self.organizer.email hasSuffix:organizerEmailSuffix]) {
        organizerName = self.organizer.displayName;
    } else {
        for (GTLCalendarEventAttendee *a in self.attendees) {
            if (!a.resource && [a.email hasSuffix:organizerEmailSuffix]) {
                if (a.displayName) {
                    organizerName = a.displayName;
                } else {
                    organizerName = [a.email stringByReplacingOccurrencesOfString:organizerEmailSuffix
                                                                       withString:@""];
                }
                break;
            }
        }
    }
    
    [cell setSummaryLabelTextWithStatus:@"Booked"
                            description:[NSString stringWithFormat:@"until %@\nby %@",
                                         [MXMCalendarEntryTableViewCell
                                          formattedTimeForDate:[[self.end dateTime] date]],
                                         organizerName]];
    
    if (indexPath.item == 0) {
        [cell setRestrictivePrimaryColors];
    } else {
        [cell setRestrictiveSecondaryColors];
    }

    return cell;
}

@end
