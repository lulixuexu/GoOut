//
//  GOCommon.h
//  GoOut
//
//  Created by Liang GUO on 6/30/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOCommon : NSObject
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;

+ (void)showHUDWithText:(NSString *)msg inView:(UIView *)view;
+ (void)showHUDWithText:(NSString *)msg;

+ (NSString *)md5WithString:(NSString *)inputStr;
@end
