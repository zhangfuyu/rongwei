//
//  DFBaseViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFBaseViewController.h"

@interface DFBaseViewController ()

@end

@implementation DFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];//DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)tabelviewAddReload
{
    self.dataTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
}

- (void)tableviewAddMoreDown
{
    self.dataTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}
- (void)refreshData
{
    
}
- (void)getMoreData
{
    
}
- (void)allocTableviewWith:(UITableViewStyle)style
{
    self.dataTableview = [[UITableView alloc]initWithFrame:CGRectZero style:style];
    self.dataTableview.showsVerticalScrollIndicator = NO;
    self.dataTableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.dataTableview];
    self.dataTableview.estimatedRowHeight = 0;

    if (@available(iOS 11.0, *)) {
        self.dataTableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        // est和代理 可选1个
        self.dataTableview.estimatedSectionFooterHeight = 0;
        self.dataTableview.estimatedSectionHeaderHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
