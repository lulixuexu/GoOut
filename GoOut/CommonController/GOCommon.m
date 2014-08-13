//
//  GOCommon.m
//  GoOut
//
//  Created by Liang GUO on 6/30/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GOCommon.h"
#import <CommonCrypto/CommonDigest.h>

#import "MBProgressHUD.h"
@implementation GOCommon
+(BOOL)isValidPhoneNumber:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSPredicate *phoneTest =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}
#pragma mark - HUD
+ (void)showHUDWithText:(NSString *)msg inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

// show hud in window
+ (void)showHUDWithText:(NSString *)msg
{
    [[self class] showHUDWithText:msg inView:[[UIApplication sharedApplication] keyWindow]];
}

+ (NSString *)md5WithString:(NSString *)inputStr
{
    const char *ptr = [inputStr UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

//
+ (void)drawLineOnView:(UIView *)superView
             lineWidth:(CGFloat )width
          strokeColor :(UIColor *)color
            startPoint:(CGPoint )sPoint
              endPoint:(CGPoint )ePoint {
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = width;
    lineShape.lineCap = kCALineCapRound;
    lineShape.strokeColor = color.CGColor;
    CGPathMoveToPoint(linePath, NULL, sPoint.x , sPoint.y );
    CGPathAddLineToPoint(linePath, NULL, ePoint.x , ePoint.y);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [superView.layer addSublayer:lineShape];
}
@end
