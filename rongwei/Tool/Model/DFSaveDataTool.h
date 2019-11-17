//
//  DFSaveDataTool.h
//  rongwei
//
//  Created by zhangfuyu on 2019/11/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFSaveDataTool : NSObject
+ (instancetype)shareInstance;

//缓存省市区所有数据
- (void)saveCountryDataWithData:(NSDictionary *)data;

- (NSDictionary *)getCountryData;

@end

NS_ASSUME_NONNULL_END
