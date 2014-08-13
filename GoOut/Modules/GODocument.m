//
//  GODocument.m
//  GoOut
//
//  Created by Liang GUO on 8/4/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#define kuserID         @"DuserID"
#define kuserAccount    @"DuserAccount"
#define kuserImage      @"DuserImage"
#define kbackground     @"Dbackground"
#define knickName       @"DnickName"
#define kqqAccount      @"DqqAccount"
#define krenAccount     @"DrenAccount"
#define kweiAccount     @"DweiAccount"

#define kconvex_hull     @"Dconvex_hull"
#import "GODocument.h"

@implementation GODocument
+ (GODocument *)fetchDocument
{
    static GODocument* document = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        document = [[self alloc] init];
    });
    return document;
}
- (id)init
{
    self = [super init];
    if (self) {
        NSUserDefaults* userData = [NSUserDefaults standardUserDefaults];
        self.userID = [userData stringForKey:kuserID];
        self.userAccount = [userData stringForKey:kuserAccount];
        self.userImage = [userData stringForKey:kuserImage];
        self.background =  [userData stringForKey:kbackground];
        self.nickName = [userData stringForKey:knickName];
        self.qqAccount = [userData stringForKey:kqqAccount];
        self.renAccount = [userData stringForKey:krenAccount];
        self.weiAccount = [userData stringForKey:kweiAccount];
        //convex hull
        self.convex_hull = [userData objectForKey:kconvex_hull];
    }
    return self;
}
- (void)saveDocument
{
    NSUserDefaults *tempDefaults = [NSUserDefaults standardUserDefaults];
    //
    [tempDefaults setObject:self.userID forKey:kuserID];
    [tempDefaults setObject:self.userAccount forKey:kuserAccount];
    [tempDefaults setObject:self.userImage forKey:kuserImage];
    [tempDefaults setObject:self.background forKey:kbackground];
    [tempDefaults setObject:self.nickName forKey:knickName];
    [tempDefaults setObject:self.qqAccount forKey:kqqAccount];
    [tempDefaults setObject:self.renAccount forKey:krenAccount];
    [tempDefaults setObject:self.weiAccount forKey:kweiAccount];
    
    [tempDefaults synchronize];
}
- (void)saveConvexHull
{
    NSUserDefaults *tempDefaults = [NSUserDefaults standardUserDefaults];
    //
    [tempDefaults setObject:self.convex_hull forKey:kconvex_hull];
}
@end
