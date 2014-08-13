//
//  GORegisterViewController.m
//  GoOut
//
//  Created by Liang GUO on 7/1/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GORegisterViewController.h"
#import "GOCommon.h"
#import "GONetworkController.h"
#import "GOMainPageViewController.h"
#import <SMS_SDK/SMS_SDK.h>
@interface GORegisterViewController ()
@property (nonatomic,strong)UIButton* registerButton;
@property (nonatomic,strong)UITextField* phoneNumText;
@property (nonatomic,strong)UITextField* passwordText;
@property (nonatomic,strong)UIButton* sendCode;

@property (nonatomic, assign) NSInteger countDownsec;
@property (nonatomic, strong) NSTimer* autoTimer;
@end

@implementation GORegisterViewController

#pragma mark -- Initation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initTitle{
    [self setTitleText:@"注册"];
}
- (void)initLayout{
    
    //textField
    _phoneNumText = [[UITextField alloc]initWithFrame:CGRectMake(20, 90, 280, 40)];
    _phoneNumText.placeholder = @"请填写手机号码";
    _phoneNumText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumText.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneNumText];
    
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(20, 90+65, 148, 40)];
    _passwordText.placeholder = @"验证码";
    _passwordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordText.keyboardType = UIKeyboardTypeAlphabet;
    [self.view addSubview:_passwordText];
    
    // button
    _sendCode = [[UIButton alloc]initWithFrame:CGRectMake(170, 90+65, 120, 40)];
    [_sendCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendCode setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    [_sendCode setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_sendCode addTarget:self action:@selector(AutoSendButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendCode];
    
    _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 225, 280, 40)];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    _registerButton.backgroundColor = BUTTON_COLOR;
    [_registerButton.layer setCornerRadius:10.0];
    [_registerButton addTarget:self action:@selector(registerButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
}
#pragma mark -- Event Handling
- (void)AutoSendButtonEvent:(UIButton*)sender
{
    //test phone num
    if ([GOCommon isValidPhoneNumber:_phoneNumText.text]){
        
//        [SMS_SDK getVerifyCodeByPhoneNumber:_phoneNumText.text AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state){
//            switch (state) {
//                case SMS_ResponseStateGetVerifyCodeSuccess:{
//                    //成功发送
//                    NSString* str=[NSString stringWithFormat:@"验证码发送成功"];
//                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"发送成功" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//                    break;
//                case SMS_ResponseStateGetVerifyCodeFail:{
//                    //发送失败
//                    NSLog(@"block 获取验证码失败");
//                    NSString* str=[NSString stringWithFormat:@"验证码发送失败 请稍后重试"];
//                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"发送失败" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//                    break;
//                case SMS_ResponseStateMaxVerifyCode:{
//                    //请求验证码超上限
//                    NSString* str=[NSString stringWithFormat:@"请求验证码超上限 请稍后重试"];
//                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"超过上限" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//                    break;
//                case SMS_ResponseStateGetVerifyCodeTooOften:{
//                    //客户端请求发送短信验证过于频繁
//                    NSString* str=[NSString stringWithFormat:@"客户端请求发送短信验证过于频繁"];
//                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//                    break;
//                default:
//                    break;
//            }
//        }];
        
        //disable for 30 sec
        _countDownsec = 30;
        [_sendCode setEnabled:NO];
        _autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(oneSec) userInfo:nil repeats:YES];
    }
    else{//not valid
        [GOCommon showHUDWithText:@"手机格式不正确"];
    }
}
- (void)oneSec
{
    //change button title every 1 sec
    if (_countDownsec != 0) {
        NSString *str = [NSString stringWithFormat:@"重新获取(%ds)",(int)_countDownsec];
        [_sendCode setTitle:str forState:UIControlStateDisabled];
        _countDownsec= _countDownsec - 1;
    }
    else{
        //time's up for enabling the button
        [_sendCode setEnabled:YES];
        [_sendCode setTitle:@"重新获取" forState:UIControlStateDisabled];
        
        //stop the repeated 1 sec timer
        [_autoTimer invalidate];
        _autoTimer = nil;
    }
}
- (void)registerButtonEvent:(UIButton*)sender
{
    if ([GOCommon isValidPhoneNumber:_phoneNumText.text]) {
        if (_passwordText.text.length >0) {
          [[GONetworkController sharedController]doRegister:_phoneNumText.text authenticateCode:_passwordText.text];
        }else{
          [GOCommon showHUDWithText:@"验证码格式错误"];
        }
    }
    else{//not valid
        [GOCommon showHUDWithText:@"手机格式不正确"];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSInteger resultIdentifier = [[change objectForKey:@"new"] integerValue];
    switch (resultIdentifier) {
        case REGISTER_SUCCESS:
        {
            [GOCommon showHUDWithText:@"注册成功"];
            GOMainPageViewController* ctrl = [[GOMainPageViewController alloc]init];
            [self pushViewControllerBottomToTop:ctrl animated:YES];
        }
            break;
        case REGISTER_FAILURE:
        {
            [GOCommon showHUDWithText:@"注册失败，已存在的用户"];
        }
            break;
        case REGISTER_TIME_OUT:
        {
            [GOCommon showHUDWithText:@"无法连接服务器"];
        }
            break;
        default:
            break;
    }
}
#pragma mark -- life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor redColor];
    [self initTitle];
    [self initLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
