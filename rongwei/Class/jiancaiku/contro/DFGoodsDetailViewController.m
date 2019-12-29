//
//  DFGoodsDetailViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGoodsDetailViewController.h"
#import "DFGoodsDetailModel.h"
#import "DFGoodsDetailNavView.h"
#import "DFGoodsHeaderView.h"
#import "DFStoreModel.h"
#import "DFStoreGoodModel.h"
#import "DFGoodsTableViewCell.h"
#import "DFSecondHeaderView.h"


@interface DFGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) DFGoodsDetailNavView *navView;

@property (nonatomic , strong) DFGoodsDetailModel *goodDetailmodel;

@property (nonatomic , strong) NSMutableArray *goods_arry;//推荐商品列表

@property (nonatomic , strong) DFGoodsHeaderView *headerview;

@property (nonatomic , strong) DFSecondHeaderView *sceondView;

@end

@implementation DFGoodsDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
    WEAKSELF;
    self.navView.selectType = ^(NSInteger selectBtnTag) {
        if (selectBtnTag == 100) {
            [weakSelf.dataTableview scrollToTop];
        }
        else if (selectBtnTag == 101)
        {
            weakSelf.dataTableview.contentOffset = CGPointMake(0, weakSelf.headerview.commentSet - kNavBarAndStatusBarHeight);
        }
        else if (selectBtnTag == 102)
        {
            weakSelf.dataTableview.contentOffset = CGPointMake(0, weakSelf.headerview.detailSet - kNavBarAndStatusBarHeight);

        }
        else
        {
            [weakSelf.dataTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }
    };
    
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-kBottomSafeHeight -HScaleHeight(54));
    }];
    self.dataTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.dataTableview.tableHeaderView = self.headerView;
    self.dataTableview.tableFooterView = nil;
    
    
    [self.navView changeSelectWith:NO];
    
    [self.view bringSubviewToFront:self.navView];
    
    [self getGoodsDetail];
    

    
    
}

- (void)getGoodsDetail
{
//    self.goods_id = @"5";
    NSString *ursStr = [NSString stringWithFormat:@"%@/%@",ShopGoods,self.goods_id];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ursStr withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            DFGoodsDetailModel *model = [[DFGoodsDetailModel alloc]initWithDictionary:response[@"data"] error:nil];
            NSLog(@"---->%@",model);
            self.goodDetailmodel = model;
            

            
            [self getShopGoodsComment];
            
            [self getShopDetailWith:model.shop_id];
        }
            
    }];
}

/// 获取店铺详情
/// @param shop_id 店铺id
- (void)getShopDetailWith:(NSString *)shop_id
{
    
    NSString *ursStr = [NSString stringWithFormat:@"%@/%@",ShopStore,shop_id];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ursStr withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            DFStoreModel *model = [[DFStoreModel alloc]initWithDictionary:response[@"data"] error:nil];
            self.goodDetailmodel.shopDetailModel = model;
            
            self.headerview = [[DFGoodsHeaderView alloc]initWithFrame:CGRectZero withModel:self.goodDetailmodel];
            WEAKSELF;
            self.headerview.globalBlockInMemory = ^(float headerHeight) {
                weakSelf.headerview.frame = CGRectMake(0, 0, ScreenW, headerHeight);
                [weakSelf.dataTableview reloadData];
            };
            self.dataTableview.tableHeaderView = self.headerview;
            
            [self getShopGoodsWithHShop:shop_id];
        }
            
    }];
}
- (void)getShopGoodsWithHShop:(NSString *)shop_id
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopGoods withParameter:@{@"is_rec":@"1",@"shop_id":shop_id} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFStoreGoodModel *model = [[DFStoreGoodModel alloc]initWithDictionary:dataarry[index] error:nil];
                
                if (![model.spu_id isEqualToString:self.goodDetailmodel.spu_id]) {
                                   
                    [self.goods_arry addObject:model];

                }
            }
            
            [self.dataTableview reloadData];
            
        }
            
    }];

}

- (void)getShopGoodsComment
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopGoodsComment withParameter:@{@"spu_id":self.goods_id} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
           
        }
            
    }];
}

#pragma gram - mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.goods_arry.count % 2 > 0 ? self.goods_arry.count / 2 + 1 : self.goods_arry.count / 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid = @"DFGoodsTableViewCell";
    DFGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[DFGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.goodArry = self.goods_arry;
    cell.indexPath = indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return HScaleHeight(128.5);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return HScaleHeight(47);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sceondView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat bottomCellOffset = [self.dataTableview rectForSection:0].origin.y;

    
    
    if (scrollView.contentOffset.y >= kNavBarAndStatusBarHeight) {
        
        [self.navView changeSelectWith:YES];
    }
    if (scrollView.contentOffset.y >= self.headerview.commentSet- kNavBarAndStatusBarHeight)
    {
        [self.navView changeLineviewMesonry:1];
    }
    if (scrollView.contentOffset.y >= self.headerview.detailSet- kNavBarAndStatusBarHeight)
    {
        [self.navView changeLineviewMesonry:2];

    }
    if (scrollView.contentOffset.y >= bottomCellOffset- kNavBarAndStatusBarHeight)
    {
        [self.navView changeLineviewMesonry:3];

    }
    if (scrollView.contentOffset.y <= 0)
    {
        [self.navView changeLineviewMesonry:0];

        [self.navView changeSelectWith:NO];
    }
    
}

- (DFGoodsDetailNavView *)navView
{
    if (!_navView) {
        _navView = [[DFGoodsDetailNavView alloc]init];
        [self.view addSubview:_navView];
    }
    return _navView;
}
- (NSMutableArray *)goods_arry
{
    if (!_goods_arry) {
        _goods_arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _goods_arry;
}

- (DFSecondHeaderView *)sceondView
{
    if (!_sceondView) {
        _sceondView = [[DFSecondHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(47)) withtitle:@"为您推荐"];
        _sceondView.backgroundColor = [UIColor whiteColor];
    }
    return _sceondView;
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
