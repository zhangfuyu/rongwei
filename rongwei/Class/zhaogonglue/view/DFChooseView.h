//
//  DFChooseView.h
//  rongwei
//
//  Created by apple on 2019/10/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFChooseView : UIView

@property (nonatomic, copy) void (^clickTypeBlock)(NSString *clickTitle);


@property (nonatomic, strong)  NSMutableArray *titleArry;


@end

NS_ASSUME_NONNULL_END
