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

@interface DFFindGonglueViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)DFChooseView *chooseview;

@property (nonatomic , strong)DFStrategyHeaderView *tableviewHeader;

@property (nonatomic , strong)NSMutableArray *list_arry;

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
    
    [self getdata];
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

- (void)getdata
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsGuide withParameter:@{@"is_rec":@"0"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
