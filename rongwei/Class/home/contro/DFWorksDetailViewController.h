//
//  DFWorksDetailViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/3.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFDesignerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFWorksDetailViewController : DFBaseViewController

@property (nonatomic , strong) NSString *worksId;

@property (nonatomic , strong) NSString *autherID;

@property (nonatomic , strong) DFDesignerModel *model;

@end

NS_ASSUME_NONNULL_END
