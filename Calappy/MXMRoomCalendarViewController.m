//
//  MXMRoomCalendarViewController.m
//  Calappy
//
//  Created by Dan Brown on 13/03/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "MXMRoomCalendarViewController.h"
#import "MXMTableCells.h"

@implementation MXMRoomCalendarViewController

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
    
    self.events = [[NSMutableArray alloc] init];
    self.googleManager = [[MXMGoogleManager alloc] init];
    self.googleManager.delegate = self;
    self.clockRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                              target:self
                                                            selector:@selector(refreshClock)
                                                            userInfo:nil
                                                             repeats:YES];
    self.eventRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                                              target:self
                                                            selector:@selector(reloadEventsIfAuthPresent)
                                                            userInfo:nil
                                                             repeats:YES];
    
    // Need to manually stick in a "back" gesture, as we haven't got a visible Back button
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handlePopGesture)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.navigationController.view addGestureRecognizer:gestureRecognizer];

    [self.googleManager showAuthIfRequiredByPushingTo:[self navigationController] animated:NO];
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

- (void)handlePopGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshClock
{
    self.clockLabel.text = [MXMCalendarEntryTableViewCell formattedTimeForDate:[NSDate date]];
}

- (void)googleManagerReadyForQuerying
{
    self.hasAuth = YES;
    [self reloadEvents];
}

- (void)setCalendarId:(NSString *)calendarId
{
    _calendarId = calendarId;
    [self reloadEventsIfAuthPresent];
}

- (void)reloadEventsIfAuthPresent
{
    if (self.hasAuth) {
        [self reloadEvents];
    }
}

- (void)reloadEvents
{
    @synchronized(self.events) {
        [self.events removeAllObjects];
    }
    
    if (!self.calendarId) {
        [self.tableView reloadData];
        return;
    }
    
    [self.googleManager eventsForCalendarId:self.calendarId completionBlock:^(NSArray *events, NSError *error) {
        if (error) {
            [self setErrorMessage:[error localizedDescription]];
        } else {
            @synchronized(self.events) {
                [self.events removeAllObjects];
                [self.events addObjectsFromArray:events];
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)setErrorMessage:(NSString *)message
{
    /* XXX: Ugly bit. Putting in a fake free period so a cell will be created so we can change it into
     * an error message. But it does work.
     */
    @synchronized(self.events) {
        [self.events removeAllObjects];
        [self.events addObject:[[MXMFreePeriod alloc] initWithDateTime:[NSDate date] duration:nil]];
    }
    [self.tableView reloadData];
    
    MXMCalendarEntryTableViewCell *firstCell =
    (MXMCalendarEntryTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                                               inSection:0]];
    if (firstCell != nil) {
        [firstCell setRestrictivePrimaryColors];
        firstCell.summaryLabel.text = message;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSUInteger count;
        @synchronized(self.events) {
            count = [self.events count];
        }
        return count;
    } else {
        @throw [NSException exceptionWithName:@"RuntimeException" reason:@"Unknown section" userInfo:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        id <MXMTableCells> event;
        @synchronized(self.events) {
            // FIXME: race condition between this and refreshing data. Definitely witnessed a crash here,
            // when scrolling and a refresh happening at the same time.
            event = [self.events objectAtIndex:indexPath.item];
        }
        
        MXMCalendarEntryTableViewCell *cell = [event cellForTableView:tableView atIndexPath:indexPath];
        if (indexPath.item == 0) {
            self.clockLabel = cell.clockLabel;
            [self refreshClock];
        }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
