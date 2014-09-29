//
//  MXMCalendarEntryTableViewCell.h
//  Calappy
//
//  Created by Dan Brown on 01/04/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+MXMCalendarColors.h"

@interface MXMCalendarEntryTableViewCell : UITableViewCell

@property IBOutlet UILabel *clockLabel;
@property IBOutlet UILabel *summaryLabel;

+ (NSString *)formattedTimeForDate:(NSDate *)date;

- (void)setSummaryLabelTextWithStatus:(NSString *)status description:(NSString *)description;

- (void)setPermissivePrimaryColors;
- (void)setPermissiveSecondaryColors;
- (void)setRestrictivePrimaryColors;
- (void)setRestrictiveSecondaryColors;
@end
