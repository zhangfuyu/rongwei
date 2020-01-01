//
//  DFEsignerSortingViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/30.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DFEsignerSortingViewControllerDelegate <NSObject>
@optional

- (void)selectChooseEsignerSortId:(NSString *)styleId withText:(NSString *)text;

@end

@interface DFEsignerSortingViewController : DFBaseViewController

@property(nonatomic , weak)id<DFEsignerSortingViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
