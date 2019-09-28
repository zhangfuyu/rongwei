//
//  DFEsignerDetialViewController.m
//  rongwei
//
//  Created by apple on 2019/9/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFEsignerDetialViewController.h"
#import "DFDesignerView.h"
#import "DFCasesView.h"

@interface DFEsignerDetialViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)DFDesignerView *headerView;

@property (nonatomic , strong) NSMutableArray *dataArry;

@property (nonatomic , strong) DFCasesView *secondHeaderView;

@end

@implementation DFEsignerDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.model.name;
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.tableFooterView = [UIView new];
    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    
    self.dataTableview.tableHeaderView = self.headerView;
    
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:DesignerDetailApi withParameter:@{@"id":self.model.modelId} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            self.model = [[DFDesignerModel alloc]initWithDictionary:response error:nil];
            self.headerView.model = self.model;
            
            [self getWorkData];
            
        }
    }];
}

/// 作品
- (void)getWorkData
{
    NSMutableDictionary *parmar = [@{
        @"designer_id":self.model.modelId,
        @"page":@(1),
        @"page_size":@(10)
    }copy];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:WorkDesignerDetailApi withParameter:parmar withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
           if (isSuccess) {
               
              
               
           }
       }];
}

/// 个人简介
- (void)getPersonalProfile
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:DesignerAboutDetailApi withParameter:@{@"id":self.model.modelId} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
           
            
        }
    }];
}

/// 评论
- (void)getComment
{
    NSMutableDictionary *parmar = [@{
        @"designer_id":self.model.modelId,
        @"page":@(1),
        @"page_size":@(10)
    }copy];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:DesignerCommentDetailApi withParameter:parmar withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
           if (isSuccess) {
               
              
               
           }
       }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    return self.dataArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScaleHeight(242);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScaleHeight(40);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.secondHeaderView;
}

- (NSMutableArray *)dataArry
{
    if (!_dataArry) {
        _dataArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArry;
}
- (DFDesignerView *)headerView
{
    if (!_headerView) {
        _headerView = [[DFDesignerView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(192))];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (DFCasesView *)secondHeaderView
{
    if (!_secondHeaderView) {
        _secondHeaderView = [[DFCasesView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(40))];
        _secondHeaderView.backgroundColor = [UIColor whiteColor];
        _secondHeaderView.titleArry = [NSMutableArray arrayWithArray:@[@"作品（20）",@"个人简介",@"评价"]];
//        __weak typeof(self) weakself = self;
        _secondHeaderView.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
//            if ([clickTitle isEqualToString:@"精选点评"]) {
//                weakself.contentCell.pageContentView.contentViewCurrentIndex = 0;
//            }
//            else
//            {
//                weakself.contentCell.pageContentView.contentViewCurrentIndex = 1;
//            }
        };
    }
    return _secondHeaderView;
}

@end
