//
//  GOBaseViewController.m
//  GoOut
//
//  Created by Liang GUO on 7/2/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GOBaseViewController.h"
#import "GOCommon.h"

@interface GOBaseViewController ()
{
    CGFloat barSpacing;
}
@end

@implementation GOBaseViewController

#pragma mark -- UI Controller Transition
- (void)pushViewControllerBottomToTop:(GOBaseViewController*)viewctrl animated:(BOOL)animation
{
    
    if (viewctrl == nil || self.navigationController == nil) {
        return;
    }
    @try {
        if (animation) {
//            CGSize viewSize = viewctrl.view.bounds.size;
//            viewctrl.view.frame = CGRectMake(0, viewSize.height, viewSize.width, viewSize.height);
//             self.view.alpha = 1;
//            [UIView animateWithDuration:1
//                                  delay:0
//                                options:UIViewAnimationOptionTransitionCurlUp
//                             animations:^{
//            viewctrl.view.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
//                                 
//            }
//                             completion:^(BOOL finished){
//                
//            }];
        }
        [self.navigationController pushViewController:viewctrl animated:NO];
    }
    @catch (NSException *exception) {
        NSLog(@"{%@} push controller error",self.class);
    }
    @finally {
        
    }
}
- (void)popViewControllerAnimation:(BOOL)animation
{
    if (self.navigationController == nil) {
        return;
    }
    @try {
        if (animation) {
            //            viewctrl.slideInDirection = RASlideInDirectionBottomToTop;
            //            viewctrl.shiftBackDropView = YES;
            //            viewctrl.backDropViewAlpha = .4f;
        }
        [self.navigationController popViewControllerAnimated:NO];
    }
    @catch (NSException *exception) {
        NSLog(@"{%@} POP controller error",self.class);
    }
    @finally {
        
    }
}
- (void)popToRootViewControllerAnimation:(BOOL)animation
{
    if (self.navigationController == nil) {
        return;
    }
    @try {
        if (animation) {
            //            viewctrl.slideInDirection = RASlideInDirectionBottomToTop;
            //            viewctrl.shiftBackDropView = YES;
            //            viewctrl.backDropViewAlpha = .4f;
        }
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    @catch (NSException *exception) {
        NSLog(@"{%@} POP To Root controller error",self.class);
    }
    @finally {
        
    }
}
- (void)popToViewController:(GOBaseViewController*)viewController animation:(BOOL)animation
{
    if (viewController == nil ||self.navigationController == nil) {
        return;
    }
    @try {
        if (animation) {
            //            viewctrl.slideInDirection = RASlideInDirectionBottomToTop;
            //            viewctrl.shiftBackDropView = YES;
            //            viewctrl.backDropViewAlpha = .4f;
        }
        [self.navigationController popToViewController:viewController animated:NO];
    }
    @catch (NSException *exception) {
        NSLog(@"{%@} POP To view controller error",self.class);
    }
    @finally {
        
    }
}
- (void)leftButton:(id)sender{
    [self popViewControllerAnimation:YES];
}
- (void)rightButton:(id)sender{
    
}
#pragma mark -- Initiation
- (void)initializeData
{
    barSpacing = 0.0;
    self.statusBarHidden = NO;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeData];
    }
    return self;
}
- (void)loadStatusBar
{
    CGRect frame = CGRectZero;
    frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, barSpacing);
    self.statusBarView = [[UIView alloc] initWithFrame:frame];
    [self.statusBarView setBackgroundColor:STATUSBAR_COLOR];
    self.statusBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_statusBarView];
}

- (void)initNavigationBar
{
    CGRect frame = CGRectZero;
    
    frame = CGRectMake(0, __DEVICE_OS_VERSION_7_0?STATUSBARHEIGHT:0, SCREEN_WIDTH, TOPBARHEIGHT);
    
    _naviBarView = [[UIView alloc] initWithFrame:frame];
    _naviBarView.backgroundColor = STATUSBAR_COLOR;
    [self.view addSubview:_naviBarView];
    _naviBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _naviBarView.autoresizesSubviews = YES;
    
    //Title头信息
    frame = CGRectMake(60, 0, 200, TOPBARHEIGHT);
    _titleLabel = [[UILabel alloc]initWithFrame:frame];
    _titleLabel.font=[UIFont boldSystemFontOfSize:17];
    _titleLabel.numberOfLines = 1;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    //    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.shadowOffset = CGSizeMake(1, 1);
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _titleText;
    [_naviBarView addSubview:self.titleLabel];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.naviBarView bringSubviewToFront:self.view];
    
    CGPoint startPoint = CGPointMake(0, CGRectGetHeight(self.naviBarView.frame));
    CGPoint endPoint = CGPointMake(SCREEN_HEIGHT, CGRectGetHeight(self.naviBarView.frame));
    [GOCommon drawLineOnView:self.naviBarView lineWidth:0.6 strokeColor:STATUSBAR_COLOR startPoint:startPoint endPoint:endPoint];
    
    //left button
    _leftButton = [GOCustomLeftButton newLeftButton];
    [_leftButton addTarget:self action:@selector(leftButton:) forControlEvents:UIControlEventTouchUpInside];
    _leftButton.text = @"Back";
    _leftButton.textColor = RGB_COLOR(0, 122, 255);
    [self.naviBarView addSubview:_leftButton];
    
    //right button
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 60, TOPBARHEIGHT);
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    //    _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _rightButton.backgroundColor = [UIColor clearColor];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.naviBarView addSubview:_rightButton];
    _rightButton.hidden = YES;
    
}
#pragma mark setTitle
- (void)setTitleText:(NSString *)titleText
{
    if (_titleText != titleText) {
        _titleText = titleText;
    }
    self.titleLabel.text = _titleText;
}
- (CGFloat)getNaviBarHeight
{
    if (_naviBarView && !_naviBarView.isHidden) {
        return barSpacing + CGRectGetHeight(_naviBarView.frame);
    }
    return barSpacing;
}

- (CGFloat)getContentHeight
{
    CGFloat topHeight  = [self getNaviBarHeight];
    if (barSpacing == 0) {
        topHeight += STATUSBARHEIGHT;
    }
    return SCREEN_HEIGHT - topHeight;
}
#pragma mark -- life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self initialSetup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init
    
    [super viewDidLoad];
    if (__DEVICE_OS_VERSION_7_0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        barSpacing = STATUSBARHEIGHT;
        [self loadStatusBar];
    }
    [self initNavigationBar];
    
    self.view.backgroundColor = RGB_COLOR(244, 243, 241);
    
    self.interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    self.navigationController.navigationBarHidden =YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:self.statusBarHidden];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
#pragma mark - ios7 StatusBar
- (BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end