//
//  DFSalesGoodsStyleViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/30.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DFSalesGoodsStyleViewControllerDelegate <NSObject>
@optional

- (void)selectChooseSelesGoodsSortId:(NSString *)styleId withText:(NSString *)text;

@end

@interface DFSalesGoodsStyleViewController : DFBaseViewController

@property(nonatomic , weak)id<DFSalesGoodsStyleViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
