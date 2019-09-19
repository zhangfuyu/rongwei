//
//  DFAppVersionTool.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFAppVersionTool : NSObject

/**
 *  获取之前保存的版本
 *
 *  @return NSString类型的AppVersion
 */
+ (NSString *)dc_GetLastOneAppVersion;
/**
 *  保存新版本
 */
+ (void)dc_SaveNewAppVersion:(NSString *)version;


@end

NS_ASSUME_NONNULL_END
