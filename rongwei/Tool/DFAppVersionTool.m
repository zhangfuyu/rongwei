//
//  DFAppVersionTool.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFAppVersionTool.h"

@implementation DFAppVersionTool

// 获取保存的上一个版本信息
+ (NSString *)dc_GetLastOneAppVersion {
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AppVersion"];
}

// 保存新版本信息（偏好设置）
+ (void)dc_SaveNewAppVersion:(NSString *)version {
    
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"AppVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
