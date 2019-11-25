//
//  DFInformationViewController.h
//  rongwei
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFCompanyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFInformationViewController : DFBaseViewController

@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong)DFCompanyModel *model;



@end

NS_ASSUME_NONNULL_END
