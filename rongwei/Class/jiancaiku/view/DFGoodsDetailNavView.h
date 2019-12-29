//
//  DFGoodsDetailNavView.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/13.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFGoodsDetailNavView : UIView


@property (nonatomic , copy)void (^selectType)(NSInteger selectBtnTag);

- (void)changeSelectWith:(BOOL)isSelect;
- (void)changeLineviewMesonry:(NSInteger)btnTag;

@end

NS_ASSUME_NONNULL_END
