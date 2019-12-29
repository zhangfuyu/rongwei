//
//  DFStageInfosSiteModel.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStageInfosSiteModel.h"

@implementation DFStageInfosSiteModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}

@end
