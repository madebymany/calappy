//
//  MXMFreePeriod+MXMTableCells.m
//  Calappy
//
//  Created by Dan Brown on 31/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "MXMFreePeriod+MXMTableCells.h"

@implementation MXMFreePeriod (MXMTableCells)

- (MXMCalendarEntryTableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"meeting";
    MXMCalendarEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                          forIndexPath:indexPath];
    cell.clockLabel.text = [MXMCalendarEntryTableViewCell formattedTimeForDate:self.startTime];
    
    NSString *description;
    if (self.duration) {
        description = @"for ";
        if (self.duration.hour > 0) {
            description = [description stringByAppendingFormat:@"%ldh ",
                           (long)self.duration.hour];
        }
        description = [description stringByAppendingFormat:@"%ldm",
                       (long)self.duration.minute];
    } else {
        description = @"for the rest of the day!";
    }
    
    [cell setSummaryLabelTextWithStatus:@"Free"
                            description:[@"\n" stringByAppendingString:description]];

    if (indexPath.item == 0) {
        [cell setPermissivePrimaryColors];
    } else {
        [cell setPermissiveSecondaryColors];
    }

    return cell;
}

@end
