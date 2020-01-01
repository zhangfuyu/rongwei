//
//  DFSortingViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/29.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DFSortingViewControllerDelegate <NSObject>
@optional

- (void)selectChooseSortId:(NSString *)styleId withText:(NSString *)text;

@end

@interface DFSortingViewController : DFBaseViewController

@property(nonatomic , weak)id<DFSortingViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
