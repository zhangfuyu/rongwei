//
//  DFMoreStoreViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/11.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFMoreStoreViewController.h"
#import "DFCategoryModel.h"
#import "DFCategaryChooseView.h"
#import "CQTopBarSegment.h"
#import "DFStoreModel.h"
#import "DFStoreListCell.h"

@interface DFMoreStoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSMutableArray *category_arry;
@property (nonatomic , strong) DFCategaryChooseView *topView;
@property (nonatomic , strong) CQTopBarSegment *segment;
@property (nonatomic , strong) NSMutableArray *store_arry;
@property (nonatomic , strong) NSMutableDictionary *parmars;
@end

@implementation DFMoreStoreViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"建材城";
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(0, 0, 44, 44);
    [search setImage:[UIImage imageNamed:@"jiancaiku_sousuo"] forState:UIControlStateNormal];
//    [message addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:search];
    
    UIButton *shopCar = [UIButton buttonWithType:UIButtonTypeCustom];
    shopCar.frame = CGRectMake(0, 0,44, 44);
    [shopCar setImage:[UIImage imageNamed:@"qicheqianlian-1-copy"] forState:UIControlStateNormal];
//    [message addTarget:self action:@selector(focusonThis) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithCustomView:shopCar];
    
    
    self.navigationItem.rightBarButtonItems = @[rightBtn2,rightBtn1];
    
    
    
//    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(HScaleHeight(37));
//    }];
//
//    WEAKSELF;
//    self.topView.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
//        [weakSelf.parmars setValue:clickTitle forKey:@""];
//    };
    
    [self getShopCategory];
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.dataTableview.separatorColor = [UIColor colorWithHexString:@"E4E4E4"];
    self.dataTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getPartners)];

    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    
    [self getPartners];
}
- (void)getShopCategory
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopCategory withParameter:@{@"is_rec":@"0"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
                
            NSArray *dataArry = response[@"data"];
            for (NSInteger index = 0; index < dataArry.count; index ++) {
                DFCategoryModel *model = [[DFCategoryModel alloc]initWithDictionary:dataArry[index] error:nil];
                [self.category_arry addObject:model];
            }
            self.topView.titleArry = self.category_arry;
        }
    }];
}

- (void)getPartners
{
    [SVProgressHUD showWithStatus:@"加载中。。。"];

    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopStore withParameter:@{@"itemsPerLoad":@"10",@"lastIndex":@(self.store_arry.count)} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFStoreModel *model = [[DFStoreModel alloc]initWithDictionary:dataarry[index] error:nil];
                [self.store_arry addObject:model];
            }
            if (dataarry.count > 1) {
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
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.store_arry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    DFStoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DFStoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = self.store_arry[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DFStoreModel *model = self.store_arry[indexPath.row];
//    if (model.carousel_image.count == 0) {
        return HScaleHeight(80);
//    }
//
//    return HScaleHeight(146.5);
}


- (NSMutableArray *)category_arry
{
    if (!_category_arry) {
        _category_arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _category_arry;
}
- (NSMutableArray *)store_arry
{
    if (!_store_arry) {
        _store_arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _store_arry;
}
- (DFCategaryChooseView *)topView
{
    if (!_topView) {
        _topView = [[DFCategaryChooseView alloc]init];
        [self.view addSubview:_topView];
    }
    return _topView;
}
- (CQTopBarSegment *)segment
{
    if (!_segment) {
        _segment = [[CQTopBarSegment alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(47)) sectionTitles:@[@"综合",@"销量有限",@"品牌"]];
        _segment.titleTextColor = [UIColor colorWithHexString:@"666666"];
        _segment.segmentImage = @"箭头";
        _segment.selectSegmentImage = @"箭头-1";
        _segment.selectedTitleTextColor = [UIColor colorWithHexString:@"DD1A21"];
        _segment.titleTextFont = HScaleFont(12);
        _segment.segmentlineColor = [UIColor clearColor];
    }
    return _segment;
}
- (NSMutableDictionary *)parmars
{
    if (!_parmars) {
        _parmars = [[NSMutableDictionary alloc]init];
    }
    return _parmars;
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
