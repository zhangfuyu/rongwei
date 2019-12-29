//
//  DFMoreGoodsListViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFMoreGoodsListViewController : DFBaseViewController

@property (nonatomic , assign) BOOL isCategory;//是否点击分类进来

@property (nonatomic , strong) NSString *category_id;

@end

NS_ASSUME_NONNULL_END
