//
//  DFYuSuanViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DFYuSuanViewControllerDelegate <NSObject>
@optional

- (void)selectChooseBudgetStyleId:(NSString *)styleId;

@end

@interface DFYuSuanViewController : DFBaseViewController
@property (nonatomic , weak)id<DFYuSuanViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
