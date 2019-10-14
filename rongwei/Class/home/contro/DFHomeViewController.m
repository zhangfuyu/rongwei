//
//  DFHomeViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFHomeViewController.h"
#import "DFEsignerlListViewController.h"
#import "DFHomeHeaderView.h"

@interface DFHomeViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation DFHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    
    [self allocTableviewWith:UITableViewStylePlain];
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kTabBarHeight);
    }];
    
    DFHomeHeaderView *headerview = [[DFHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(526) + kStatusBarHeight)];
  
    self.dataTableview.tableHeaderView = headerview;
    
//    [self.navigationController pushViewController:[DFEsignerlListViewController new] animated:YES];
//    [[DFUserModelTool shareInstance] showLoginViewController];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellidear = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidear];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidear];
    }
    return cell;
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
