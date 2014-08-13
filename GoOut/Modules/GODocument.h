//
//  GODocument.h
//  GoOut
//
//  Created by Liang GUO on 8/4/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GODocument : NSObject

@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * userAccount;
@property (nonatomic, retain) NSString * userImage;
@property (nonatomic, retain) NSString * background;
@property (nonatomic, retain) NSString * nickName;
@property (nonatomic, retain) NSString * qqAccount;
@property (nonatomic, retain) NSString * renAccount;
@property (nonatomic, retain) NSString * weiAccount;

@property (nonatomic, retain) NSArray* convex_hull;
+ (GODocument *)fetchDocument;

- (void)saveDocument;
- (void)saveConvexHull;
@end
