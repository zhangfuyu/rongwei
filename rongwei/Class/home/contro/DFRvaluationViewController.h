//
//  DFRvaluationViewController.h
//  rongwei
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFRvaluationViewController : DFBaseViewController
@property (nonatomic , strong)NSString *constructionid;
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic , strong) UITableView *scrollView;

@end

NS_ASSUME_NONNULL_END
