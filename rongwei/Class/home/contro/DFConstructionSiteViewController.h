//
//  DFConstructionSiteViewController.h
//  rongwei
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFConstructionSiteViewController : DFBaseViewController

@property (nonatomic , strong) NSString *constructionid;//

@property (nonatomic, assign) BOOL vcCanScroll;

@property (nonatomic , strong) UICollectionView *scrollView;


@end

NS_ASSUME_NONNULL_END
