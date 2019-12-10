//
//  DFWorksDetailView.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/3.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFDesignerWorkModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface DFWorksDetailView : UIView

- (instancetype)initWithFrame:(CGRect)frame withModel:(DFDesignerWorkModel *)model;

@property (nonatomic , copy)void (^globalBlockInMemory)(float headerHeight);


@end

NS_ASSUME_NONNULL_END
