//
//  DFContructionDetailViewController.h
//  rongwei
//
//  Created by apple on 2019/11/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFCompanyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFContructionDetailViewController : DFBaseViewController

@property (nonatomic , strong)DFCompanyModel *model;

@property (nonatomic , strong)NSString *shop_id;

@end

NS_ASSUME_NONNULL_END
