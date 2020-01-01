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
#import "DFStrategyView.h"
#import "DFInformationCell.h"
#import "DFZiXunListViewController.h"

@interface DFFindGonglueViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)DFChooseView *chooseview;

@property (nonatomic , strong)DFStrategyHeaderView *tableviewHeader;

@property (nonatomic , strong)NSMutableArray *list_arry;

@property (nonatomic , strong)NSMutableArray *hot_arry;

@property (nonatomic , strong)DFStrategyView *navview;

@property (nonatomic , assign)BOOL isInformation;//是否是咨询

@property (nonatomic , strong)NSString *chooseID;

@end

@implementation DFFindGonglueViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"找攻略";
    // Do any additional setup after loading the view.
//    self.chooseview.titleArry = [NSMutableArray arrayWithArray:@[@"全部",@"装修设计",@"预算报价",@"建材购买",@"验房收房",@"其他"]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chaGongLue) name:@"chaGongLue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FoundZiXun) name:@"FoundZiXun" object:nil];
    
    [self.navview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
    WEAKSELF;
    self.navview.chooseConditionsBlock = ^(DFconditions conditon) {
        if (conditon == DFStrategy_information) {//资讯
            
            weakSelf.isInformation = YES;
            weakSelf.dataTableview.separatorColor = [UIColor clearColor];
        }
        else
        {
            weakSelf.isInformation = NO;
            weakSelf.dataTableview.separatorColor = [UIColor colorWithHexString:@"F7F7F7"];

        }
        [weakSelf.list_arry removeAllObjects];
        [weakSelf getdataWithClassId:weakSelf.chooseID];
    };
    
    self.chooseview.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
        weakSelf.chooseID = clickTitle;
        [weakSelf.list_arry removeAllObjects];
        [weakSelf getdataWithClassId:clickTitle];
    };
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];

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
- (void)chaGongLue
{
    self.navview.sTraTegyStyle = DFStrategy_Strategy;
    self.isInformation = NO;
    self.dataTableview.separatorColor = [UIColor colorWithHexString:@"F7F7F7"];
    
    [self.list_arry removeAllObjects];
    [self getdataWithClassId:self.chooseID];

}

- (void)FoundZiXun
{
    self.navview.sTraTegyStyle = DFStrategy_information;
    self.isInformation = YES;
    self.dataTableview.separatorColor = [UIColor clearColor];
    [self.list_arry removeAllObjects];
    [self getdataWithClassId:self.chooseID];


}
- (void)getMoreData
{
           
    [self getdataWithClassId:self.chooseID];

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
    
    if (self.isInformation) {
        static NSString *cellid = @"DFInformationCell";
        DFInformationCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[DFInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        cell.model = self.list_arry[indexPath.row];
        return cell;
    }
    static NSString *cellid = @"DFStrategyTableViewCell";
    DFStrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DFStrategyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.list_arry[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.isInformation) {
        DFGongLueModel *model = self.list_arry[indexPath.row];
        if (model.last_comment.length == 0) {
            return HScaleHeight(82.5);
        }
        else
        {
            
        }
        CGFloat commentHeight = [model.last_comment heightForFont:HScaleFont(12) width:ScreenW - HScaleWidth(42)];
        
        return HScaleHeight(82.5) + commentHeight;
    }
    
    return HScaleHeight(90);
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DFGongLueModel *model = self.list_arry[indexPath.row];
    
    if (self.isInformation) {
        DFZiXunListViewController *zixun = [[DFZiXunListViewController alloc]init];
        zixun.model = model;
        [self.navigationController pushViewController:zixun animated:YES];
    }
    else
    {
        DFStrategyDetailViewController *detail = [[DFStrategyDetailViewController alloc]init];
        detail.modelid = model.modelId;
        detail.isInformation = self.isInformation;
        [self.navigationController pushViewController:detail animated:YES];
    }

}

- (void)getMoreClass
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsClass withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
         if (isSuccess) {
             
             
             NSMutableArray *titleArry = [NSMutableArray arrayWithCapacity:0];
             
             NSDictionary *dic = [@{@"id":@"",
                                    @"name":@"全部",
                                    @"sort":@"0"
             }copy];
             
             [titleArry addObject:dic];
             
             NSArray *dataArry = response[@"data"];
             
             for (NSInteger index = 0; index < dataArry.count; index ++) {
                 NSDictionary *dic = dataArry[index];
                 [titleArry addObject:dic];
             }
             
             
             self.chooseview.titleArry = titleArry;
             NSDictionary *firsedic = self.chooseview.titleArry.firstObject;
             self.chooseID = [NSString stringWithFormat:@"%@",firsedic[@"id"]];
             [self getdataWithClassId:dic[@"id"]];
         }
     }];
}

- (void)getdataWithClassId:(NSString *)classid
{
    

    [SVProgressHUD showWithStatus:@"加载中"];
    
    NSString *urlStr = @"";
    
    if (self.isInformation) {
        urlStr = BbsAdvisory;
    }
    else
    {
        urlStr = BbsGuide;
    }
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:urlStr withParameter:@{@"is_rec":@"0",@"class_id":classid,@"itemsPerLoad":@"10",@"lastIndex":@(self.list_arry.count)} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            
            
            NSArray *dataArry = response[@"data"];
            if (dataArry.count > 0) {
                for (NSDictionary *dic in dataArry) {
                    DFGongLueModel *model = [[DFGongLueModel alloc]initWithDictionary:dic error:nil];
                    [self.list_arry addObject:model];
                }
                [self.dataTableview.mj_footer endRefreshing];

            }
            else
            {
                [self.dataTableview.mj_footer endRefreshingWithNoMoreData];
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
- (DFStrategyView *)navview
{
    if (!_navview) {
        _navview = [[DFStrategyView alloc]init];
        [self.view addSubview:_navview];
    }
    return _navview;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
