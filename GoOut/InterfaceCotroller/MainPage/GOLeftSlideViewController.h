//
//  GOLeftSlideViewController.h
//  GoOut
//
//  Created by Liang GUO on 7/22/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GODrawerSection){
    GO_MAPVIEW,
    GO_FRIENDS,
    GO_SETTINGS,
    GO_CHALLENGES,
};

@interface GOLeftSlideViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@end
