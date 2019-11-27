//
//  DFRecommendedViewController.h
//  rongwei
//
//  Created by apple on 2019/11/27.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFRecommendedViewController : DFBaseViewController

@property (nonatomic , strong) UICollectionView *scrollView;

@property (nonatomic, assign) BOOL vcCanScroll;


@end

NS_ASSUME_NONNULL_END
