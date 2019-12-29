//
//  DFStoreHeaderView.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFStoreModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFStoreHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame withModel:(DFStoreModel *)model;

@property (nonatomic , copy)void (^selectTypeBtn)(NSInteger type , NSString *titleText);

@end

NS_ASSUME_NONNULL_END
