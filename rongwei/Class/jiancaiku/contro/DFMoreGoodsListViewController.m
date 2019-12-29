//
//  DFMoreGoodsListViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFMoreGoodsListViewController.h"
#import "CQTopBarSegment.h"
#import "DFStoreGoodModel.h"
#import "DFGoodsListCollectionViewCell.h"
#import "DFCategoryModel.h"
#import "DFCategaryChooseView.h"
#import "DFAllCategaryView.h"
@interface DFMoreGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CQTopBarSegmentDelegate>

@property (nonatomic , strong) CQTopBarSegment *segment;
@property (nonatomic , strong) UICollectionView *scrollView;
@property (nonatomic , strong) NSMutableArray *goods_arry;
@property (nonatomic , strong) NSMutableArray *category_arry;
@property (nonatomic , strong) DFCategaryChooseView *topView;
@property (nonatomic , strong) DFAllCategaryView *allTopView;

@end

@implementation DFMoreGoodsListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"建材库";
    
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
    
    
    WEAKSELF;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(37));
    }];
    
    
    self.topView.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
        weakSelf.allTopView.clickId = clickTitle;
        weakSelf.category_id = clickTitle;
        [weakSelf.goods_arry removeAllObjects];
        [weakSelf getShopGoods];
    };
    self.topView.clickShowAllCategaeyBlock = ^{
        [weakSelf.view bringSubviewToFront:weakSelf.allTopView];
        weakSelf.allTopView.hidden = NO;
    };
    
    self.allTopView.clickTypeBlock = ^(NSString * _Nonnull clickTitle) {
        weakSelf.topView.clickId = clickTitle;
        weakSelf.category_id = clickTitle;
        [weakSelf.goods_arry removeAllObjects];
        [weakSelf getShopGoods];
    };
    
    
    [self.view addSubview:self.segment];
    
     // 创建布局
     // 1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

     
     // 创建collectionView
     self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight + HScaleHeight(47) + HScaleHeight(37), ScreenW ,ScreenH - kNavAndTabHeight - HScaleHeight(47)- HScaleHeight(37))collectionViewLayout:layout];
     self.scrollView.backgroundColor = [UIColor whiteColor];
     self.scrollView.delegate = self;
     self.scrollView.dataSource = self;
     self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = YES;
     self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.scrollView registerClass:[DFGoodsListCollectionViewCell class] forCellWithReuseIdentifier:@"DFGoodsListCollectionViewCell"];
    
    self.scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getShopGoods)];
    [self.view addSubview:self.scrollView];
    
    [self getShopCategory];
    
    [self getShopGoods];
}

- (void)getShopCategory
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopCategory withParameter:@{@"is_rec":@"0"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
                
            NSArray *dataArry = response[@"data"];
            
            DFCategoryModel *firstModel = [[DFCategoryModel alloc]init];
            firstModel.category_name = @"全部";
            [self.category_arry addObject:firstModel];
            
            for (NSInteger index = 0; index < dataArry.count; index ++) {
                DFCategoryModel *model = [[DFCategoryModel alloc]initWithDictionary:dataArry[index] error:nil];
                [self.category_arry addObject:model];
            }
            self.topView.titleArry = self.category_arry;
            self.allTopView.titleArry = self.category_arry;
            
            self.topView.clickId = self.category_id;
            self.allTopView.clickId = self.category_id;
            
        }
    }];
}

- (void)getShopGoods
{
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSMutableDictionary *parmar = [[NSMutableDictionary alloc]init];
    
    if (self.isCategory) {
        parmar[@"category_id"] = self.category_id;
    }
    parmar[@"itemsPerLoad"] = @"10";
    parmar[@"lastIndex"] = @(self.goods_arry.count);
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopGoods withParameter:parmar withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataarry = response[@"data"];
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFStoreGoodModel *model = [[DFStoreGoodModel alloc]initWithDictionary:dataarry[index] error:nil];
                [self.goods_arry addObject:model];
            }
                
            if (dataarry.count > 1) {
                [self.scrollView.mj_footer endRefreshing];
            }
            else
            {
                [self.scrollView.mj_footer endRefreshingWithNoMoreData];

            }
            [self.scrollView reloadData];
        }
            
    }];

}

#pragma mark - 代理方法 Delegate Methods
// 设置分区

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goods_arry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFGoodsListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFGoodsListCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.goods_arry[indexPath.row];
    
     
    return cell;
}

// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((ScreenW - HScaleWidth(30)) / 2, HScaleHeight(123.5));
}


// 设置UIcollectionView整体的内边距（这样item不贴边显示）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section % 2 > 0) {
        
        return UIEdgeInsetsMake(0, 0, 0, HScaleWidth(10));

    }
    else
    {
        return UIEdgeInsetsMake(0, 10, 0,HScaleWidth(10));

    }
    // 上 左 下 右
}

// 设置minimumLineSpacing：cell上下之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return HScaleHeight(10);
}

// 设置minimumInteritemSpacing：cell左右之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return HScaleHeight(10);
}

- (void)topBarSegmentWithBlock:(CQTopBarSegment *)segment indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
    }
}

- (CQTopBarSegment *)segment
{
    if (!_segment) {
        _segment = [[CQTopBarSegment alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight  + HScaleHeight(37), ScreenW, HScaleHeight(47)) sectionTitles:@[@"默认",@"价格",@"销量"]];
        _segment.titleTextColor = [UIColor colorWithHexString:@"666666"];
        _segment.segmentImage = @"箭头";
        _segment.delegate = self;
        _segment.selectSegmentImage = @"箭头-1";
        _segment.selectedTitleTextColor = [UIColor colorWithHexString:@"DD1A21"];
        _segment.titleTextFont = HScaleFont(12);
        _segment.segmentlineColor = [UIColor clearColor];
    }
    return _segment;
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

- (DFCategaryChooseView *)topView
{
    if (!_topView) {
        _topView = [[DFCategaryChooseView alloc]init];
        [self.view addSubview:_topView];
    }
    return _topView;
}
- (DFAllCategaryView *)allTopView
{
    if (!_allTopView) {
        _allTopView = [[DFAllCategaryView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(37))];
        _allTopView.hidden = YES;
        [self.view addSubview:_allTopView];
    }
    return _allTopView;
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
