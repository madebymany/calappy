//
//  MXMRoomSelectViewController.m
//  Calappy
//
//  Created by Dan Brown on 02/04/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "MXMRoomSelectViewController.h"

@implementation MXMRoomSelectViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendarNames = @[resourceOneCalendarName, resourceTwoCalendarName];
    self.calendarIds = @[resourceOneCalendarId, resourceTwoCalendarId];
    
    self.savedCalendarId = [[NSUserDefaults standardUserDefaults] stringForKey:kCalendarIdUserDefault];
    if (self.savedCalendarId != nil && [self.calendarIds indexOfObject:self.savedCalendarId] != NSNotFound) {
        [self performSegueWithIdentifier:@"roomCalendarView" sender:self];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.calendarNames count];
    } else {
        @throw [NSException exceptionWithName:@"RuntimeException" reason:@"Unknown section" userInfo:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"room";
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                forIndexPath:indexPath];
        cell.textLabel.text = [self.calendarNames objectAtIndex:indexPath.item];
        return cell;
    } else {
        @throw [NSException exceptionWithName:@"RuntimeException" reason:@"Unknown section" userInfo:nil];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    MXMRoomCalendarViewController *dest = [segue destinationViewController];
    NSString *calendarId;
    
    if (self.savedCalendarId) {
        @synchronized(self) {
            calendarId = self.savedCalendarId;
            self.savedCalendarId = nil;
        }
    } else {
        calendarId = [self.calendarIds objectAtIndex:[self.tableView indexPathForCell:sender].row];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:calendarId forKey:kCalendarIdUserDefault];
        [defaults synchronize];
    }
    dest.calendarId = calendarId;
}

@end
