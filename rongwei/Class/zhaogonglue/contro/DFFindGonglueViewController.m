//
//  DFFindGonglueViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFFindGonglueViewController.h"
#import "DFChooseView.h"
#import "DFStrategyHeaderView.h"
#import "DFStrategyTableViewCell.h"

@interface DFFindGonglueViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)DFChooseView *chooseview;

@property (nonatomic , strong)DFStrategyHeaderView *tableviewHeader;

@end

@implementation DFFindGonglueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找攻略";
    // Do any additional setup after loading the view.
    self.chooseview.titleArry = [NSMutableArray arrayWithArray:@[@"全部",@"装修设计",@"预算报价",@"建材购买",@"验房收房",@"其他"]];
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.chooseview.mas_bottom);
        make.bottom.mas_equalTo(-kTabBarHeight);
    }];

    self.dataTableview.tableHeaderView = self.tableviewHeader;
    self.dataTableview.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"DFStrategyTableViewCell";
    DFStrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DFStrategyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScaleHeight(90);
}

- (DFChooseView *)chooseview
{
    if (!_chooseview) {
        _chooseview = [[DFChooseView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(37))];
        [self.view addSubview:_chooseview];
    }
    return _chooseview;
}
- (DFStrategyHeaderView *)tableviewHeader
{
    if (!_tableviewHeader) {
        _tableviewHeader = [[DFStrategyHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenH, HScaleHeight(150))];
    }
    return _tableviewHeader;
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
