//
//  LoginViewController.m
//  GoOut
//
//  Created by Liang GUO on 6/20/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GOLoginViewController.h"
#import "GONetworkController.h"
#import "GOCommon.h"

@interface GOLoginViewController ()
@property (nonatomic,strong)UITextField* accountLabel;
@property (nonatomic,strong)UITextField* pwdLabel;
@property (nonatomic,strong)UIButton* loginButton;
@end

@implementation GOLoginViewController
#pragma mark - initialzation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initLoginView{
    
    //init textField
    CGRect frame = CGRectMake(20, 120, 280, 40);
    _accountLabel = [[UITextField alloc] initWithFrame:frame];
    _accountLabel.placeholder = @"手机号";
    _accountLabel.borderStyle = UITextBorderStyleRoundedRect;
    _accountLabel.keyboardType = UIKeyboardTypeNumberPad;
    _accountLabel.tag= 100;
    [self.view addSubview:_accountLabel];
    
    frame = CGRectMake(20, 120+60, 280, 40);
    _pwdLabel = [[UITextField alloc] initWithFrame:frame];
    _pwdLabel.placeholder = @"密码";
    _pwdLabel.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_pwdLabel];
    
    //init UIButton
    frame = CGRectMake(20, 120+60+100, 280, 40);
    _loginButton = [[UIButton alloc] initWithFrame:frame];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.backgroundColor = [UIColor greenColor];
    [_loginButton.layer setCornerRadius:10.0];
    [_loginButton addTarget:self action:@selector(loginButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
}
#pragma mark - Event Control
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)loginButtonEvent:(UIButton*)button
{
    if ([GOCommon isValidPhoneNumber:_accountLabel.text]) {
        //valid number
        [[GONetworkController sharedController]doLogin:_accountLabel.text password:_pwdLabel.text];
    }
    else{//not valid
        [GOCommon showHUDWithText:@"手机格式不正确"];
    }
}
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initLoginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate//ToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
{
    return　NO;
}
@end
