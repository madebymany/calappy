//
//  MXMViewController.m
//  Calappy
//
//  Created by Dan Brown on 21/02/2014.
//  Copyright (c) 2014 Made by Many. All rights reserved.
//

#import "MXMViewController.h"

@interface MXMViewController ()
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end

@implementation MXMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
