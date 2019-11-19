//
//  DFCommentModel.m
//  rongwei
//
//  Created by apple on 2019/11/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCommentModel.h"

@implementation DFCommentModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}

@end
