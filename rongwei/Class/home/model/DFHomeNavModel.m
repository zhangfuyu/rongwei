//
//  DFHomeNavModel.m
//  rongwei
//
//  Created by apple on 2019/11/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFHomeNavModel.h"

@implementation DFHomeNavModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}
@end
