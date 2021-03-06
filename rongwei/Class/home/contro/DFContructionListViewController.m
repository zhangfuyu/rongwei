//
//  DFContructionListViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFContructionListViewController.h"
#import "DFTextField.h"
#import "CQTopBarSegment.h"
#import "DFConstructionListView.h"
#import "DFConstructionModel.h"
#import "DFConstructionListCell.h"
#import "DFContructionWorkDetailViewController.h"
#import "DFConstructionPhaseViewController.h"
#import "DFDecorateFamilyViewController.h"
#import "DFChooseCityViewController.h"

@interface DFContructionListViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,DFConstructionPhaseViewControllerDelegate,DFDecorateFamilyViewControllerDelegate,DFChooseCityViewControllerDelegate,CQTopBarSegmentDelegate>

@property (nonatomic , strong) DFTextField *searchTextField;
@property (nonatomic , strong) CQTopBarSegment *segment;
@property (nonatomic , strong) DFConstructionListView *header;
@property (nonatomic , strong) UICollectionView *scrollView;
@property (nonatomic , strong) NSMutableArray *constructionArry;
@property (nonatomic , strong) NSMutableDictionary *parmars;

@property (nonatomic , strong) DFConstructionPhaseViewController *stylevc;

@property (nonatomic , strong) DFDecorateFamilyViewController *DecorateFamily;

@property (nonatomic , strong) DFChooseCityViewController *chooseCity;

@end

@implementation DFContructionListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.parmars = [[NSMutableDictionary alloc]init];
    
    [self setupNavigationBar];
    
    self.header = [[DFConstructionListView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(189.5))];

    
    [self allocTableviewWith:UITableViewStylePlain];
    
    self.dataTableview.tableHeaderView = self.header;
    self.dataTableview.tableFooterView = self.scrollView;
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.bottom.mas_equalTo(-kBottomSafeHeight);
    }];
    
    [self getConstruction];
    
}
//请求施工列表
- (void)getConstruction
{
    
    self.parmars[@"itemsPerLoad"] = @(10);
    self.parmars[@"lastIndex"] = @(self.constructionArry.count);
    self.parmars[@"is_rec"] = @(0);
    
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:Construction withParameter:self.parmars withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            [self.scrollView.mj_footer endRefreshing];

            
            NSArray *dataarry = response[@"data"];
            
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFConstructionModel *model = [[DFConstructionModel alloc]initWithDictionary:dataarry[index] error:nil];
                [self.constructionArry addObject:model];
            }
            if (dataarry.count >0) {
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
- (void)setupNavigationBar
{

    UIView *navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, kNavBarAndStatusBarHeight)];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
//    [self.navigationController.navigationBar addSubview:navigationView];
    [self.view addSubview:navigationView];

//    self.navigationView = navigationView;

    self.searchTextField = [[DFTextField alloc]initWithFrame:CGRectZero];
    self.searchTextField.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
    self.searchTextField.layer.cornerRadius = 14;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTextField.userInteractionEnabled = YES;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"找施工" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"],
                 NSFontAttributeName:[UIFont systemFontOfSize:12]
         }];
    self.searchTextField.enabled = YES;
    self.searchTextField.attributedPlaceholder = attrString;
    self.searchTextField.font = [UIFont systemFontOfSize:12];
//    searchTextField.delegate = self;
    self.searchTextField.textColor = [UIColor blackColor];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
//    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
//    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
//    searchTextField.layer.shadowOpacity = 1;
//    searchTextField.layer.shadowRadius = 4;
    

    [navigationView addSubview:self.searchTextField];
                                                                      
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(8 +kStatusBarHeight);
        make.left.mas_equalTo(HScaleWidth(62.5));
        make.height.mas_equalTo(28);
        make.right.mas_equalTo(-HScaleWidth(62.5));
    }];
                                                                      
    self.searchTextField.leftSpace = 29;

    UIView *lefrview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14 + 15, 28)];
                                      
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"sousuo"];

    [lefrview addSubview:searchIconImageView];
    
    [searchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.mas_equalTo(lefrview.mas_centerY);
    }];
    
    [self.searchTextField addSubview:lefrview];


//    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];




    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [searchButton setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchButton];

    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchTextField.mas_right);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kStatusBarHeight);
        make.right.mas_equalTo(0);
    }];
    
    

    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];



}
- (void)clickCancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellid = @"Cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellid];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScaleHeight(47);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.segment;
}

#pragma mark - 代理方法 Delegate Methods
// 设置分区

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.constructionArry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFConstructionListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFConstructionListCell" forIndexPath:indexPath];
    cell.model = self.constructionArry[indexPath.row];
    
     
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    DFConstructionModel *model = self.constructionArry[indexPath.row];
    DFContructionWorkDetailViewController *detail = [[DFContructionWorkDetailViewController alloc]init];
    detail.contructionWork_ID = [NSString stringWithFormat:@"%@",model.modelid];
    [self.navigationController pushViewController:detail animated:YES];
    
//    DFStoreGoodModel *model = self.goods_arry[indexPath.row];
//    DFGoodsDetailViewController *goodsDetail = [[DFGoodsDetailViewController alloc]init];
//    goodsDetail.goods_id = model.spu_id;
//    [self.navigationController pushViewController:goodsDetail animated:YES];
}
// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((ScreenW - HScaleWidth(30)) / 2, HScaleHeight(135.5));
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == self.dataTableview) {
        CGFloat bottomCellOffset = [self.dataTableview rectForSection:0].origin.y;
        if (scrollView.contentOffset.y > bottomCellOffset) {
            self.dataTableview.scrollEnabled = NO;
            self.dataTableview.contentOffset = CGPointMake(0, bottomCellOffset);
            self.scrollView.scrollEnabled = YES;
        }
    }
    else
    {
        if (scrollView.contentOffset.y < 0) {
            self.scrollView.scrollEnabled = NO;
            self.scrollView.contentOffset = CGPointMake(0, 0);

            self.dataTableview.scrollEnabled = YES;
        }
    }
    

}

- (UICollectionView *)scrollView
{
    if (!_scrollView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

         
         // 创建collectionView
         _scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW ,ScreenH - kNavAndTabHeight - HScaleHeight(47))collectionViewLayout:layout];
         _scrollView.backgroundColor = [UIColor whiteColor];
         _scrollView.delegate = self;
         _scrollView.dataSource = self;
        _scrollView.scrollEnabled = NO;
        _scrollView.alwaysBounceVertical=YES;

//         _scrollView.showsVerticalScrollIndicator = NO;
         _scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getConstruction)];

        [_scrollView registerClass:[DFConstructionListCell class] forCellWithReuseIdentifier:@"DFConstructionListCell"];
        
    }
    return _scrollView;
}

- (CQTopBarSegment *)segment
{
    if (!_segment) {
        _segment = [[CQTopBarSegment alloc]initWithFrame:CGRectMake(0, HScaleHeight(5), ScreenW, HScaleHeight(47)) sectionTitles:@[@"区域选择",@"施工阶段",@"筛选"]];
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
- (NSMutableArray *)constructionArry
{
    if (!_constructionArry) {
        _constructionArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _constructionArry;
}
- (void)topBarSegmentWithBlock:(CQTopBarSegment *)segment indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        CGFloat contentY = [self.dataTableview rectForSection:0].origin.y;
        self.dataTableview.contentOffset = CGPointMake(0, contentY);
        self.stylevc.view.hidden = !self.stylevc.view.hidden;

    }
    else if (indexPath.row == 2)
    {
        CGFloat contentY = [self.dataTableview rectForSection:0].origin.y;
        self.dataTableview.contentOffset = CGPointMake(0, contentY);
        self.DecorateFamily.view.hidden = !self.DecorateFamily.view.hidden;
    }
    else
    {
        CGFloat contentY = [self.dataTableview rectForSection:0].origin.y;
        self.dataTableview.contentOffset = CGPointMake(0, contentY);
        self.chooseCity.view.hidden = !self.DecorateFamily.view.hidden;
    }
}
- (void)topBarSegmentWithSegmentView:(CQTopBarSegment *)segmentView
{
    [self.segment.collectionView reloadData];
    self.chooseCity.view.hidden = YES;
    self.DecorateFamily.view.hidden = YES;
    self.stylevc.view.hidden = YES;
    
}

- (DFConstructionPhaseViewController *)stylevc
{
    if (!_stylevc) {
        _stylevc = [[DFConstructionPhaseViewController alloc]init];
        _stylevc.delegate = self;
        _stylevc.view.hidden = YES;
        [self addChildViewController:_stylevc];
        [self.view addSubview:_stylevc.view];
        
        [_stylevc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(47));
        }];
    }
    return _stylevc;
}
- (void)selectChooseStyleId:(NSString *)styleId withText:(nonnull NSString *)text
{
    
    [self.segment.collectionView reloadData];
    
    if (text.length == 0) {
        return;
    }

    text = [text stringByReplacingOccurrencesOfString:@"不限" withString:@"施工阶段"];
    
    [self.segment topBarReplaceObjectsAtIndexes:1 withObjects:text BarView:nil];
    self.parmars[@"stage_id"] = styleId;
    self.stylevc.view.hidden = YES;
    [self.segment.collectionView reloadData];
    [self.constructionArry removeAllObjects];
    [self getConstruction];

}
- (DFDecorateFamilyViewController *)DecorateFamily
{
    if (!_DecorateFamily) {
        _DecorateFamily = [[DFDecorateFamilyViewController alloc]init];
        _DecorateFamily.delegate = self;
        _DecorateFamily.view.hidden = YES;
        [self addChildViewController:_DecorateFamily];
        [self.view addSubview:_DecorateFamily.view];
        
        [_DecorateFamily.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(47));
        }];
    }
    return _DecorateFamily;
}

- (void)selectChooseDoorModelStyleId:(NSString *)styleId withText:(NSString *)text
{
    [self.segment.collectionView reloadData];
    
    if (text.length == 0) {
        return;
    }
    
    text = [text stringByReplacingOccurrencesOfString:@"不限" withString:@"筛选"];

    
    [self.segment topBarReplaceObjectsAtIndexes:2 withObjects:text BarView:nil];
    
    self.parmars[@"shape_id"] = styleId;

    self.DecorateFamily.view.hidden = YES;
    [self.segment.collectionView reloadData];
    
    [self.constructionArry removeAllObjects];
    [self getConstruction];
}

- (DFChooseCityViewController *)chooseCity
{
    if (!_chooseCity) {
        _chooseCity = [[DFChooseCityViewController alloc]init];
        _chooseCity.delegate = self;
        _chooseCity.view.hidden = YES;
        [self addChildViewController:_chooseCity];
        [self.view addSubview:_chooseCity.view];
        
        [_chooseCity.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(47));
        }];
    }
    return _chooseCity;
}
- (void)selectChooseprovinceId:(NSString *)province_id city_id:(NSString *)cityID area_id:(NSString *)areaId
{
    
    [self.segment.collectionView reloadData];
    self.parmars[@"province_id"] = province_id;
    self.parmars[@"city_id"] = cityID;
    self.parmars[@"area_id"] = areaId;
    
    [self.constructionArry removeAllObjects];
    [self getConstruction];

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
