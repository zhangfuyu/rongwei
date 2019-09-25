//
//  YYMacro.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#ifndef YYMacro_h
#define YYMacro_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#define kWXAppKey             @"wx9cf296975442a767"
#define AppSecret             @"05fb23bfb0d3cb1314938cb46e8aa9d7"


/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX ScreenW >=375.0f && ScreenH >=812.0f&& kIs_iphone


/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(kIs_iPhoneX?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(kIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(kIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)





// 对字符串做特殊的宏，即保证返回的值不为空
#define ISNIL(x) (((x) == nil || [(x) isEqual:[NSNull null]]) ? @"" : (x))

//获取当前版本号
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//全局背景色
#define DCBGColor RGB(245,245,245)


#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];


/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define HScaleHeight(height) ceil(ScreenW / 375 * height)

#define HScaleWidth(width) ceil(ScreenW / 375 * width)

#define HScaleFont(size) [UIFont systemFontOfSize:floor(size * (ScreenW / 375.f)) > size ? size : floor(size * (ScreenW / 375.f))]


/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;


#endif /* YYMacro_h */
