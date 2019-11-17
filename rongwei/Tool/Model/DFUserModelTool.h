//
//  DFUserModelTool.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFUserModelTool : NSObject

+ (instancetype)shareInstance;

/**
 是否有网络
 */
@property (nonatomic, assign) BOOL isHaveNetwork;

/**
 token
 */
@property (nullable, nonatomic, copy) NSString *token;

/**
 是否已经登录
 */
@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) NSString *uid;


/// 首页banaer 上
@property (nonatomic , strong) NSMutableArray *banaerArry;


/// 图标导航下方广告
@property (nonatomic , strong) NSMutableArray *navDownArry;

/// 热门攻略
@property (nonatomic , strong) NSMutableArray *hotArry;

- (void)showLoginViewController;


/// 地区(省市区)列表 数据
- (void)getcitydata;

@end

NS_ASSUME_NONNULL_END
