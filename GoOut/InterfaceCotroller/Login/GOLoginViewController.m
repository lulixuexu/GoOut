//
//  LoginViewController.m
//  GoOut
//
//  Created by Liang GUO on 6/20/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GOLoginViewController.h"
#import "GONetworkController.h"
#import "GORegisterViewController.h"
#import "GOForgotPasswordViewController.h"
#import "GOCommon.h"
#import "GOMainPageViewController.h"
@interface GOLoginViewController ()
@property (nonatomic,strong)UITextField* accountTextField;
@property (nonatomic,strong)UITextField* pwdTextField;
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
    _accountTextField = [[UITextField alloc] initWithFrame:frame];
    _accountTextField.placeholder = @"手机号";
    _accountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_accountTextField];
    
    frame = CGRectMake(20, 120+60, 280, 40);
    _pwdTextField = [[UITextField alloc] initWithFrame:frame];
    _pwdTextField.placeholder = @"密码";
    _pwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    _pwdTextField.keyboardType = UIKeyboardTypeAlphabet;
    [self.view addSubview:_pwdTextField];
    
    //init registerButton
    UIButton* registerButton= [[UIButton alloc]initWithFrame:CGRectMake(25, 120+60+60, 52, 40)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor clearColor];
    [registerButton.layer setCornerRadius:10.0];
    [registerButton addTarget:self action:@selector(registerButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    //init registerButton
    UIButton* forgetButton= [[UIButton alloc]initWithFrame:CGRectMake(194, 120+60+60, 97, 40)];
    [forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetButton.backgroundColor = [UIColor clearColor];
    [forgetButton.layer setCornerRadius:10.0];
    [forgetButton addTarget:self action:@selector(forgotButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
    
    //statement label
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(25, 354, 141, 40)];
    label.text = @"其他登陆方式:";
    [self.view addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    
    //three way of login
    UIButton* button1 = [[UIButton alloc]initWithFrame:CGRectMake(25, 388, 40, 40)];
    UIImage* image1 = [UIImage imageNamed:@"weibo_icon"];
    [button1 setImage:image1 forState:UIControlStateNormal];
    //button1.backgroundColor = [UIColor colorWithPatternImage:image1];
    [self.view addSubview:button1];
    
    UIButton* button2 = [[UIButton alloc]initWithFrame:CGRectMake(25+50, 388, 40, 40)];
    UIImage* image2 = [UIImage imageNamed:@"qq_icon"];
    [button2 setImage:image2 forState:UIControlStateNormal];
    //button1.backgroundColor = [UIColor colorWithPatternImage:image1];
    [self.view addSubview:button2];
    
    UIButton* button3 = [[UIButton alloc]initWithFrame:CGRectMake(25+100, 388, 40, 40)];
    UIImage* image3 = [UIImage imageNamed:@"people_icon"];
    [button3 setImage:image3 forState:UIControlStateNormal];
    //button1.backgroundColor = [UIColor colorWithPatternImage:image1];
    [self.view addSubview:button3];
    
    //init UIButton
    frame = CGRectMake(20, 120+60+100, 280, 40);
    _loginButton = [[UIButton alloc] initWithFrame:frame];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.backgroundColor = STATUSBAR_COLOR;
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
    if ([GOCommon isValidPhoneNumber:_accountTextField.text]) {
        //valid number
        [[GONetworkController sharedController]doLogin:_accountTextField.text password:_pwdTextField.text];
    }
    else{//not valid
        [GOCommon showHUDWithText:@"手机格式不正确"];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSInteger resultIdentifier = [[change objectForKey:@"new"] integerValue];
    switch (resultIdentifier) {
        case LOGIN_SUCCESS:
        {
            [GOCommon showHUDWithText:@"登陆成功"];
            GOMainPageViewController* ctrl = [[GOMainPageViewController alloc]init];
            [self pushViewControllerBottomToTop:ctrl animated:YES];
        }
            break;
        case LOGIN_FAILURE:
        {
            [GOCommon showHUDWithText:@"密码错误"];
        }
            break;
        case LOGIN_TIME_OUT:
        {
            [GOCommon showHUDWithText:@"无法连接服务器"];
        }
            break;
        default:
            break;
    }
}
- (void)registerButtonEvent:(UIButton*)button
{
    GORegisterViewController *regCtrl = [[GORegisterViewController alloc] init];
    [self pushViewControllerBottomToTop:regCtrl animated:YES];
}
- (void)forgotButtonEvent:(UIButton*)button
{
    GOForgotPasswordViewController *forgotCtrl = [[GOForgotPasswordViewController alloc] init];
    [self pushViewControllerBottomToTop:forgotCtrl animated:YES];
}
#pragma mark - life cycle

- (void)viewDidLoad
{
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initLoginView];
    // for test
    _accountTextField.text = @"13950234245";
    _pwdTextField.text = @"gl";
    
    self.naviBarView.hidden = YES;
    //self.navigationController.navigationBar.hidden= YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //add observer to the resultIdentifier value change in NetworkControl
    [[GONetworkController sharedController] addObserver:self forKeyPath:@"resultIdentifier" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //remove observer to the resultIdentifier value change in NetworkControl
    [[GONetworkController sharedController] removeObserver:self forKeyPath:@"resultIdentifier"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// ios6 and 7 use this two method
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}
@end
