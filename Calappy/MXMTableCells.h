//
//  MXMTableCells.h
//  Calappy
//
//  Created by Dan Brown on 31/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MXMTableCells <NSObject>

- (MXMCalendarEntryTableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
