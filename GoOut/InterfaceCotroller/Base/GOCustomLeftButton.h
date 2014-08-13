//
//  GOCustomLeftButton.h
//  GoOut
//
//  Created by Liang GUO on 7/18/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOCustomLeftButton : UIControl
+ (GOCustomLeftButton*)newLeftButton;

@property (nonatomic, strong) UIColor       *textColor;
@property (nonatomic, strong) NSString      *text;

@end
