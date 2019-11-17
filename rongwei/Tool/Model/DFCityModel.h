//
//  DFCityModel.h
//  rongwei
//
//  Created by zhangfuyu on 2019/11/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFCityModel : JSONModel

@property (nonatomic , strong) NSString<Optional> *modelid;

@property (nonatomic , strong) NSString<Optional> *level;

@property (nonatomic , strong) NSString<Optional> *name;

@property (nonatomic , strong) NSString<Optional> *pid;

@property (nonatomic , strong) NSDictionary<Optional> *region;

@property (nonatomic , strong) NSDictionary<Optional> *city;




@end

NS_ASSUME_NONNULL_END
