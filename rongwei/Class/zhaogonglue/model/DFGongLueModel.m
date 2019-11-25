//
//  DFGongLueModel.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGongLueModel.h"

@implementation DFGongLueModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id",
                                                                  @"modelclass":@"class"
    }];
}

@end
