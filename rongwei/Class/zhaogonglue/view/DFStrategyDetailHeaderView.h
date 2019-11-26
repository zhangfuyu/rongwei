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

- (instancetype)initWithFrame:(CGRect)frame withModel:(DFGongLueModel *)model;

@property (nonatomic , strong) DFGongLueModel *model;

@end

NS_ASSUME_NONNULL_END
