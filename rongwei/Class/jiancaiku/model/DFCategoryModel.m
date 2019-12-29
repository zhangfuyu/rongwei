//
//  DFCategoryModel.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/11.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCategoryModel.h"

@implementation DFCategoryModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}

@end
