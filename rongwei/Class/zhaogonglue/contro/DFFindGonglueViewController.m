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
#import "DFGongLueModel.h"
#import "DFStrategyDetailViewController.h"
#import "DFHomeNavModel.h"

@interface DFFindGonglueViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)DFChooseView *chooseview;

@property (nonatomic , strong)DFStrategyHeaderView *tableviewHeader;

@property (nonatomic , strong)NSMutableArray *list_arry;

@property (nonatomic , strong)NSMutableArray *hot_arry;

@end

@implementation DFFindGonglueViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找攻略";
    // Do any additional setup after loading the view.
//    self.chooseview.titleArry = [NSMutableArray arrayWithArray:@[@"全部",@"装修设计",@"预算报价",@"建材购买",@"验房收房",@"其他"]];
    WEAKSELF;
    self.chooseview.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
        [weakSelf getdataWithClassId:clickTitle];
    };
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
    
    [self getMoreClass];
    [self getnav];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list_arry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"DFStrategyTableViewCell";
    DFStrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DFStrategyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = self.list_arry[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScaleHeight(90);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DFGongLueModel *model = self.list_arry[indexPath.row];
    DFStrategyDetailViewController *detail = [[DFStrategyDetailViewController alloc]init];
    detail.modelid = model.modelId;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)getMoreClass
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsClass withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
         if (isSuccess) {
             
             self.chooseview.titleArry = [NSMutableArray arrayWithArray:response[@"data"]];
             NSDictionary *dic = self.chooseview.titleArry.firstObject;
             [self getdataWithClassId:dic[@"id"]];
         }
     }];
}

- (void)getdataWithClassId:(NSString *)classid
{
    

    [SVProgressHUD showWithStatus:@"加载中"];
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsGuide withParameter:@{@"is_rec":@"0",@"class_id":classid} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            [self.list_arry removeAllObjects];
            
            NSArray *dataArry = response[@"data"];
            if (dataArry.count > 0) {
                for (NSDictionary *dic in dataArry) {
                    DFGongLueModel *model = [[DFGongLueModel alloc]initWithDictionary:dic error:nil];
                    [self.list_arry addObject:model];
                }
                
            }
            [self.dataTableview reloadData];
        }
    }];
}
- (void)getnav
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsADS withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *hot = response[@"data"][@"app_hot"];//[@"APP-热门攻略广告位"];
            for (NSInteger index = 0; index < hot.count; index ++) {
                NSDictionary *dic = hot[index];
                DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                [self.hot_arry addObject:model];

            }
            self.tableviewHeader.hotarry = self.hot_arry;
        }
    }];
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
- (NSMutableArray *)list_arry
{
    if (!_list_arry) {
        _list_arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _list_arry;
}
- (NSMutableArray *)hot_arry
{
    if (!_hot_arry) {
        _hot_arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _hot_arry;
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
