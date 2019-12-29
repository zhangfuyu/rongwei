//
//  DFStrategyView.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
   
    DFStrategy_information  = 0, //资讯
    DFStrategy_Strategy = 1,//攻略
    
} DFconditions;

@interface DFStrategyView : UIView

@property (nonatomic , copy) void (^chooseConditionsBlock)(DFconditions conditon);


@end

NS_ASSUME_NONNULL_END
