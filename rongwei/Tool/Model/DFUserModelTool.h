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


- (void)showLoginViewController;

@end

NS_ASSUME_NONNULL_END
