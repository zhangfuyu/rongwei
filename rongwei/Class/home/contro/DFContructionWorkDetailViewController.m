//
//  DFContructionWorkDetailViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFContructionWorkDetailViewController.h"
#import "DFConstructionModel.h"
#import "DFConstructionHeaderView.h"
#import "DFStageInfosSiteModel.h"
#import "DFConstructionSiteCell.h"

@interface DFContructionWorkDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) DFConstructionHeaderView *headerView;
@property (nonatomic , strong) NSMutableArray *site_Arry;

@end

@implementation DFContructionWorkDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工地详情";
    [self getConstruction];
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.separatorColor = [UIColor clearColor];

    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    
    self.dataTableview.tableHeaderView = self.headerView;
    self.dataTableview.tableFooterView = [UIView new];
    
    
}
//请求工地详情
- (void)getConstruction
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",Construction,self.contructionWork_ID];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:urlStr withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSDictionary *dic = response[@"data"];
            DFConstructionModel *model = [[DFConstructionModel alloc]initWithDictionary:dic error:nil];
            self.headerView.model = model;
            [self getConstructionStageInfosSite];


        }
    }];
}

//工地阶段详情列表
- (void)getConstructionStageInfosSite
{
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:constructionSiteStageInfos withParameter:@{@"site_id":self.contructionWork_ID} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
        
            NSArray *data = response[@"data"];
            
            for (NSInteger index = 0; index < data.count; index ++) {
                DFStageInfosSiteModel *model = [[DFStageInfosSiteModel alloc]initWithDictionary:data[index] error:nil];
                [self.site_Arry addObject:model];
            }
            
            [self.dataTableview reloadData];

        }
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.site_Arry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    
    DFConstructionSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
           
        cell = [[DFConstructionSiteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    cell.model = self.site_Arry[indexPath.row];
    cell.stage_name = self.headerView.model.stage_name;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DFStageInfosSiteModel *model = self.site_Arry[indexPath.row];
    if (model.pic_json.count > 0) {
        
        if (model.note.length > 0) {
            CGFloat heightConebt = [model.note heightForFont:HScaleFont(11) width:ScreenW - HScaleWidth(49) - HScaleWidth(20.5)];
            return HScaleHeight(147) + heightConebt;
        }
        else
        {
            return HScaleHeight(147);

        }
    }
    else
    {
        if (model.note.length > 0) {
               CGFloat heightConebt = [model.note heightForFont:HScaleFont(11) width:ScreenW - HScaleWidth(49) - HScaleWidth(20.5)];
               return HScaleHeight(71) + heightConebt;
           }
           else
           {
               return HScaleHeight(71);

           }
    }
    return HScaleHeight(71);
}

- (DFConstructionHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[DFConstructionHeaderView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(252.5))];
    }
    return _headerView;
}
- (NSMutableArray *)site_Arry
{
    if (!_site_Arry) {
        _site_Arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _site_Arry;
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
