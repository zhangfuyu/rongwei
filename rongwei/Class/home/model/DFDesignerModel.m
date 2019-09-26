//
//  DFDesignerModel.m
//  rongwei
//
//  Created by apple on 2019/9/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFDesignerModel.h"

@implementation DFDesignerModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

@end
