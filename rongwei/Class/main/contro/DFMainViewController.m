//
//  DFMainViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFMainViewController.h"
#import "DFMainHeaderView.h"
#import "DFMainTableViewCell.h"
#import "DFMainDataModel.h"


@interface DFMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *mainTableView;

@property (nonatomic , strong) NSMutableArray *dataArry;

@property (nonatomic , strong) NSMutableArray *titleArry;

@end

@implementation DFMainViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArry = [DFMainDataModel getDataSource];
    self.titleArry = [DFMainDataModel getDataSourceForTitle];

    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - kTabBarHeight) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    [self.mainTableView setTableHeaderView:[DFMainHeaderView new]];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    [self.mainTableView setTableFooterView:[UIView new]];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = self.view.backgroundColor;
}

#pragma mark - UITableviewDelegage && dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellidear = @"cell";
    DFMainTableViewCell *cell = (DFMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cellidear];
    if (!cell) {
        cell = [[DFMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidear];
        
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.subClickBtnArry = self.dataArry[indexPath.section];
    cell.titleDic = self.titleArry[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 5) {
        return 115;
    }
    else
    {
        return 190;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScaleHeight(5);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSMutableArray *)dataArry
{
    if (!_dataArry) {
        _dataArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArry;
}
- (NSMutableArray *)titleArry
{
    if (!_titleArry) {
        _titleArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArry;
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
