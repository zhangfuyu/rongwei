//
//  DFAllCategaryView.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFAllCategaryView : UIView

@property (nonatomic, copy) void (^clickTypeBlock)(NSString *clickTitle);


@property (nonatomic, strong)  NSMutableArray *titleArry;

@property (nonatomic , strong) NSString *clickId;


@end

NS_ASSUME_NONNULL_END
