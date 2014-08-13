//
//  Constants.h
//  GoOut
//
//  Created by Liang GUO on 7/18/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#ifndef GoOut_Constants_h
#define GoOut_Constants_h

//plist
#define MENULILST_PLIST     @"MenuList"

//状态栏的颜色
#define STATUSBAR_COLOR         [UIColor colorWithRed:141.f/255.f green:184.f/255.f blue:29.f/255.f alpha:1]
//按钮颜色
#define BUTTON_COLOR            [UIColor colorWithRed:141.f/255.f green:184.f/255.f blue:29.f/255.f alpha:1]
#define DISABLE_BUTTON_COLOR            [UIColor colorWithRed:141.f/255.f green:184.f/255.f blue:29.f/255.f alpha:1]

//高德地图APIKEY
const static NSString *APIKey = @"c266827c64553a7b102a901aeac271d1";

//ShareSDK短信验证
#define APPKEY     @"287f1979bfe3"
#define APPSECRET  @"c6b649329381bcd432bf864319862426"

// 系统控件默认高度
#define STATUSBARHEIGHT       (20.0f)
#define TOPBARHEIGHT          (44.0f)
#define BOTTOMHEIGHT          (49.0f)
// 英文输入法键盘高度
#define ENGLISHKEYBOARDHEIGHT (216.f)
// 中文输入法键盘高度
#define CHINESEKEYBOARDHEIGHT (252.f)
// 当前系统版本
#define SYSTEMVERSION         ([[[UIDevice currentDevice] systemVersion] doubleValue])

// 颜色(RGB)
#define RGB_COLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
/*
 *
 */
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define __DEVICE_OS_VERSION_7_0 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define __DEVICE_SCREEN_SIZE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


/*
 * CoreData filter
 */
#define kNullProperty(property)             [(property) isKindOfClass:[NSNull class]]
#define kArrayProperty(property)            [(property) isKindOfClass:[NSArray class]]
#define kDictProperty(property)             [(property) isKindOfClass:[NSDictionary class]]
#define kErrorProperty(property)            [(property) isKindOfClass:[NSError class]]



#endif
