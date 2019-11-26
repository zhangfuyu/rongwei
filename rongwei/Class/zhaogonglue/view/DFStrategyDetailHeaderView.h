//
//  DFStrategyDetailHeaderView.h
//  rongwei
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFGongLueModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface DFStrategyDetailHeaderView : UIView


@property (nonatomic , strong) DFGongLueModel *model;

@property (nonatomic , copy)void (^globalBlockInMemory)(float headerHeight);

@end

NS_ASSUME_NONNULL_END
