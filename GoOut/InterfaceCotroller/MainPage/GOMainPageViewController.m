//
//  GOMainPageViewController.m
//  GoOut
//
//  Created by Liang GUO on 7/22/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GOMainPageViewController.h"
#import "GOBaseMapViewController.h"
#import "GOLeftSlideViewController.h"
@interface GOMainPageViewController ()

@end

@implementation GOMainPageViewController
#pragma mark -- Initiation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initDrawerView
{
    UIViewController* centerViewController = [[GOBaseMapViewController alloc]init];
    
    
    UIViewController* leftViewController = [[GOLeftSlideViewController alloc]init];
    
    _drawerCtrl = [[MMDrawerController alloc]initWithCenterViewController:centerViewController leftDrawerViewController:leftViewController];
    [_drawerCtrl setMaximumLeftDrawerWidth:200.0];
    [_drawerCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawerCtrl setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
//    [_drawerCtrl
//     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//         MMDrawerControllerDrawerVisualStateBlock block;
//         block = [[MMExampleDrawerVisualStateManager sharedManager]
//                  drawerVisualStateBlockForDrawerSide:drawerSide];
//         if(block){
//             block(drawerController, drawerSide, percentVisible);
//         }
//     }];
    [self presentViewController:_drawerCtrl animated:YES completion:^{}];
    
}
#pragma mark -- life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initDrawerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
