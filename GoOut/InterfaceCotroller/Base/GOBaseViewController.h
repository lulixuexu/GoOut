//
//  GOBaseViewController.h
//  GoOut
//
//  Created by Liang GUO on 7/2/14.
//  Copyright (c) 2014 bst. All rights reserved.
///Users/liangguo

#import <UIKit/UIKit.h>
#import "RASlideInViewController.h"
#import "GOCustomLeftButton.h"

//#define STATUSBAR_COLOR         [UIColor redColor]
@interface GOBaseViewController : UIViewController//RASlideInViewController

@property (assign, nonatomic) UIInterfaceOrientation interfaceOrientation;
@property (strong, nonatomic) NSString               *titleText;
@property (strong, nonatomic) UIView                 *statusBarView;
@property (strong, nonatomic) UIView                 *naviBarView;
@property (strong, nonatomic) UILabel                *titleLabel;
@property (strong, nonatomic) GOCustomLeftButton       *leftButton;
@property (strong, nonatomic) UIButton               *rightButton;
@property (assign, nonatomic) BOOL                   statusBarHidden;

- (void)leftButton:(id)sender;
- (void)rightButton:(id)sender;

- (CGFloat)getNaviBarHeight;
- (CGFloat)getContentHeight;

//View Transition Method
- (void)pushViewControllerBottomToTop:(GOBaseViewController*)viewctrl animated:(BOOL)animated;
- (void)popViewControllerAnimation:(BOOL)animation;
- (void)popToRootViewControllerAnimation:(BOOL)animation;
- (void)popToViewController:(GOBaseViewController*)viewController animation:(BOOL)animation;
@end
