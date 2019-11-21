//
//  DFCompanyModel.m
//  rongwei
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFCompanyModel.h"

@implementation DFCompanyModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}
@end
