//
//  GOCustomLeftButton.m
//  GoOut
//
//  Created by Liang GUO on 7/18/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GOCustomLeftButton.h"


@interface GOCustomLeftButton ()

@property(strong, nonatomic)UILabel         *contentLable;
@end

@implementation GOCustomLeftButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentLable = [[UILabel alloc]initWithFrame:CGRectMake(22, 0, 48, TOPBARHEIGHT)];
        _contentLable.font = [UIFont systemFontOfSize:16];
        _contentLable.textColor = [UIColor whiteColor];
        _contentLable.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentLable];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (GOCustomLeftButton*)newLeftButton
{
    GOCustomLeftButton *pButton = [[GOCustomLeftButton alloc]initWithFrame:CGRectMake(0, 0, 60, TOPBARHEIGHT)];
    return pButton;
}

- (void)setText:(NSString *)text
{
    _text = text;
    _contentLable.text = _text;
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _contentLable.textColor = _textColor;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.alpha = 0.5;
    return YES;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.alpha = 0.5;
    return YES;
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.alpha = 1;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    self.alpha = 1;
}

- (void)drawRect:(CGRect)rect
{
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(18, 12)];
    [bezierPath addCurveToPoint: CGPointMake(8, TOPBARHEIGHT/2) controlPoint1: CGPointMake(8, TOPBARHEIGHT/2) controlPoint2: CGPointMake(8, TOPBARHEIGHT/2)];
    [bezierPath addLineToPoint: CGPointMake(18, TOPBARHEIGHT - 12)];
    [_textColor setStroke];
    bezierPath.lineWidth = 2.5;
    [bezierPath stroke];
}
@end