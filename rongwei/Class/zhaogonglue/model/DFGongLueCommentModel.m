//
//  DFGongLueCommentModel.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/28.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGongLueCommentModel.h"

@implementation DFGongLueCommentModel


+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id",
                                                                  @"modelclass":@"class"
    }];
}

@end
