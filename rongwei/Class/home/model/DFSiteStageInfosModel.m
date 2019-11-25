//
//  DFSiteStageInfosModel.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSiteStageInfosModel.h"

@implementation DFSiteStageInfosModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}

@end
