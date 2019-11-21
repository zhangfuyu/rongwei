//
//  DFConstructionModel.m
//  rongwei
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFConstructionModel.h"

@implementation DFConstructionModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}

@end
