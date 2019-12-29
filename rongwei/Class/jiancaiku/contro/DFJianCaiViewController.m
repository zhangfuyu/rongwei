//
//  DFJianCaiViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFJianCaiViewController.h"
#import "DFBuildingHeaderView.h"
#import "DFHomeNavModel.h"
#import "DFSectionView.h"
#import "DFStoreModel.h"
#import "DFStoreTableViewCell.h"
#import "DFGoodsTableViewCell.h"
#import "DFStoreGoodModel.h"
#import "DFCategoryModel.h"

@interface DFJianCaiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)DFBuildingHeaderView *headerView;
@property (nonatomic , strong)NSMutableArray *app_shop_naviarry;
@property (nonatomic , strong)NSMutableArray *app_shop_banner;
@property (nonatomic , strong)DFSectionView *firstSectond;
@property (nonatomic , strong)NSMutableArray *store_arry;
@property (nonatomic , strong)NSMutableArray *goods_arry;
@property (nonatomic , strong)NSMutableArray *category_arry;
@property (nonatomic , strong)UIView *secondView;
@end

@implementation DFJianCaiViewController
    
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"建材城";
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kTabBarHeight);
    }];
    self.dataTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTableview.tableHeaderView = self.headerView;
    self.dataTableview.tableFooterView = nil;
    //请求分类列表
    [self getShopCategory];
    //请求广告
    [self getnav];
    //请求合作伙伴
    [self getPartners];
    //请求推荐商品
    [self getShopGoods];
}
- (void)getShopCategory
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopCategory withParameter:@{@"is_rec":@"1"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
                
            NSArray *dataArry = response[@"data"];
            for (NSInteger index = 0; index < dataArry.count; index ++) {
                DFCategoryModel *model = [[DFCategoryModel alloc]initWithDictionary:dataArry[index] error:nil];
                [self.category_arry addObject:model];
            }
            self.headerView.nav_arry = self.category_arry;
        }
    }];
}

- (void)getnav
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopADS withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *navi = response[@"data"][@"app_shop_navi"];//[@"APP-热门攻略广告位"];
            for (NSInteger index = 0; index < navi.count; index ++) {
                NSDictionary *dic = navi[index];
                DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                [self.app_shop_naviarry addObject:model];

            }
            
            NSArray *banner = response[@"data"][@"app_shop_banner"];
            for (NSInteger index = 0; index < banner.count; index ++) {
                NSDictionary *dic = banner[index];
                DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                [self.app_shop_banner addObject:model];
            }
            
            
            self.headerView.banaerArry = self.app_shop_naviarry;
            self.headerView.downbanaerArry = self.app_shop_banner;
        }
    }];
}
- (void)getPartners
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopStore withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFStoreModel *model = [[DFStoreModel alloc]initWithDictionary:dataarry[index] error:nil];
                [self.store_arry addObject:model];
            }
            [self.dataTableview reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            
        }
            
    }];

}

- (void)getShopGoods
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopGoods withParameter:@{@"is_rec":@"1"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFStoreGoodModel *model = [[DFStoreGoodModel alloc]initWithDictionary:dataarry[index] error:nil];
                [self.goods_arry addObject:model];
            }
            [self.dataTableview reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
            
        }
            
    }];

}

#pragma gram - mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.store_arry.count > 3) {
            return 3;
        }
        return self.store_arry.count;
        
    }
    return self.goods_arry.count % 2 > 0 ? self.goods_arry.count / 2 + 1 : self.goods_arry.count / 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *cellid = @"DFStoreTableViewCell";
        DFStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[DFStoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.model = self.store_arry[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
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
    if (indexPath.section == 0) {
        return HScaleHeight(80);
    }
    return HScaleHeight(128.5);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return HScaleHeight(39);
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstSectond;
    }
    return self.secondView;;
}


- (DFBuildingHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[DFBuildingHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(425))];
    }
    return _headerView;
}
- (DFSectionView *)firstSectond
{
    if (!_firstSectond) {
        _firstSectond = [[DFSectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(39))];
        _firstSectond.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _firstSectond.titleText = @"合作伙伴";
        _firstSectond.isShowSubTitle = NO;
    }
    return _firstSectond;
}
- (UIView *)secondView
{
    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(39))];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = HScaleBoldFont(20);
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        titleLabel.text = @"为您推荐";
        [_secondView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(HScaleWidth(10));

        }];
    }
    return _secondView;
}
- (NSMutableArray *)app_shop_naviarry
{
    if (!_app_shop_naviarry) {
        _app_shop_naviarry = [NSMutableArray arrayWithCapacity:0];
    }
    return _app_shop_naviarry;
}

- (NSMutableArray *)app_shop_banner
{
    if (!_app_shop_banner) {
       _app_shop_banner = [NSMutableArray arrayWithCapacity:0];
    }
    return _app_shop_banner;
}
- (NSMutableArray *)store_arry
{
    if (!_store_arry) {
        _store_arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _store_arry;
}

- (NSMutableArray *)goods_arry
{
    if (!_goods_arry) {
        _goods_arry = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _goods_arry;
}
- (NSMutableArray *)category_arry
{
    if (!_category_arry) {
        _category_arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _category_arry;
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
