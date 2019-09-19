//
//  DFUserModelTool.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFUserModelTool.h"

@implementation DFUserModelTool

+ (instancetype)shareInstance
{
    static DFUserModelTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[DFUserModelTool alloc] init];
        _tool.isHaveNetwork = true;
    });
    return _tool;
}

@end
