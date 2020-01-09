//
//  DFZiXunListViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFGongLueModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFZiXunListViewController : DFBaseViewController

@property (nonatomic , strong) DFGongLueModel *model;

@property (nonatomic , strong) NSString *modelID;


@end

NS_ASSUME_NONNULL_END
