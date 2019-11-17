//
//  DFCityModel.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCityModel.h"

@implementation DFCityModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}

@end
