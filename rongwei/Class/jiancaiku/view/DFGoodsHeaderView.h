//
//  DFGoodsHeaderView.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/13.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFGoodsDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFGoodsHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame withModel:(DFGoodsDetailModel *)model;

@property (nonatomic , assign) CGFloat commentSet;

@property (nonatomic , assign) CGFloat detailSet;

@property (nonatomic , copy)void (^globalBlockInMemory)(float headerHeight);


@end

NS_ASSUME_NONNULL_END
