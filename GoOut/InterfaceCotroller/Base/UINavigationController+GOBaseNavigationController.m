//
//  UINavigationController+GOBaseNavigationController.m
//  GoOut
//
//  Created by Liang GUO on 7/18/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "UINavigationController+GOBaseNavigationController.h"

@implementation UINavigationController (GOBaseNavigationController)
// ios6 and 7 use this two method
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//UIInterfaceOrientationPortrait;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation

{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}
@end
