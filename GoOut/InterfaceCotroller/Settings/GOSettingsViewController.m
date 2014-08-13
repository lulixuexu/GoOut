//
//  GOSettingsViewController.m
//  GoOut
//
//  Created by Liang GUO on 7/25/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GOSettingsViewController.h"

@interface GOSettingsViewController ()

@end

@implementation GOSettingsViewController
#pragma mark -- Initiation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark -- life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
