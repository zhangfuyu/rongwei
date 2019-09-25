//
//  DFBaseViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFBaseViewController : UIViewController

@property (nonatomic , strong)UITableView *dataTableview;

- (void)allocTableviewWith:(UITableViewStyle)style;

- (void)tabelviewAddReload;

- (void)tableviewAddMoreDown;

- (void)refreshData;
- (void)getMoreData;
@end

NS_ASSUME_NONNULL_END
