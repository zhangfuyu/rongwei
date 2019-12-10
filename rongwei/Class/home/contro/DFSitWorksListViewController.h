//
//  DFSitWorksListViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/3.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFDesignerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFSitWorksListViewController : DFBaseViewController

@property (nonatomic , strong) DFDesignerModel *sitmodel;


@property (nonatomic , strong) NSString *authorID;

@property (nonatomic , strong) UICollectionView *scrollView;

@property (nonatomic, assign) BOOL vcCanScroll;

@end

NS_ASSUME_NONNULL_END
