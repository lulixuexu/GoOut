//
//  GOBaseMapViewController.h
//  GoOut
//
//  Created by Liang GUO on 7/25/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "GOBaseViewController.h"
@interface GOBaseMapViewController : GOBaseViewController<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong) MAMapView* mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@end
