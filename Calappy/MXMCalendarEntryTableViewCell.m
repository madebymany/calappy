//
//  MXMCalendarEntryTableViewCell.m
//  Calappy
//
//  Created by Dan Brown on 01/04/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "MXMCalendarEntryTableViewCell.h"

@implementation MXMCalendarEntryTableViewCell

+ (NSString *)formattedTimeForDate:(NSDate *)date
{
    return [NSDateFormatter localizedStringFromDate:date
                                          dateStyle:NSDateFormatterNoStyle
                                          timeStyle:NSDateFormatterShortStyle];
}

- (void)setSummaryLabelTextWithStatus:(NSString *)status description:(NSString *)description
{
    CGFloat pointSize = self.summaryLabel.font.pointSize;
    UIFont *boldSummaryFont, *summaryFont;
    summaryFont = [UIFont fontWithName:@"HelveticaNeue" size:pointSize];
    boldSummaryFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:pointSize];
    
    NSMutableAttributedString *summary = [[NSMutableAttributedString alloc] init];
    [summary appendAttributedString:
     [[NSMutableAttributedString alloc] initWithString:[status stringByAppendingString:@" "]
                                            attributes:@{NSFontAttributeName: boldSummaryFont}]];
    [summary appendAttributedString:
     [[NSMutableAttributedString alloc] initWithString:description
                                            attributes:@{NSFontAttributeName: summaryFont}]];
    
    self.summaryLabel.attributedText = summary;
}

- (void)setPermissivePrimaryColors
{
    self.contentView.backgroundColor = [UIColor freePeriodBackgroundColor];
    self.clockLabel.textColor = [UIColor whiteColor];
    self.summaryLabel.textColor = [UIColor whiteColor];
}

- (void)setPermissiveSecondaryColors
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.clockLabel.textColor = [UIColor freePeriodTextColor];
    self.summaryLabel.textColor = [UIColor freePeriodTextColor];
}

- (void)setRestrictivePrimaryColors
{
    
    self.contentView.backgroundColor = [UIColor meetingBackgroundColor];
    self.clockLabel.textColor = [UIColor whiteColor];
    self.summaryLabel.textColor = [UIColor whiteColor];
}

- (void)setRestrictiveSecondaryColors
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.clockLabel.textColor = [UIColor meetingTextColor];
    self.summaryLabel.textColor = [UIColor meetingTextColor];
}

@end
