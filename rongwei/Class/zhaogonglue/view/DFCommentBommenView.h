//
//  DFCommentBommenView.h
//  rongwei
//
//  Created by zhangfuyu on 2019/11/27.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFGongLueModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFCommentBommenView : UIView

@property (nonatomic , strong) DFGongLueModel *model;
@property (nonatomic , assign)BOOL isInformation;//是否是咨询


@end

NS_ASSUME_NONNULL_END
