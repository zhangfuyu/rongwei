//
//  YYMacro.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#ifndef YYMacro_h
#define YYMacro_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 对字符串做特殊的宏，即保证返回的值不为空
#define ISNIL(x) (((x) == nil || [(x) isEqual:[NSNull null]]) ? @"" : (x))

#endif /* YYMacro_h */
