//
//  DFStoreDetailViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStoreDetailViewController.h"
#import "DFStoreModel.h"
#import "DFStoreHeaderView.h"
#import "DFStoreGoodModel.h"
#import "DFStoreDetailGoodsCell.h"
#import "DFGoodsDetailViewController.h"
@interface DFStoreDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) DFStoreModel *shop_model;
@property (nonatomic , strong) NSMutableArray *goods_arry;
@property (nonatomic , strong) UICollectionView *scrollView;

@property (nonatomic , assign) NSInteger selectType;

@end

@implementation DFStoreDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     // 创建布局
     // 1.创建流水布局

    
    [self getStoreDetail];
    

    
    
    
}

- (void)creatNavView
{
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"jiancaiku_fanhui"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
    
    
    UIButton *sharebtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW - 34.5, kStatusBarHeight, 25.5, 44)];
    sharebtn.showsTouchWhenHighlighted = NO;
    [sharebtn setImage:[UIImage imageNamed:@"store_more"] forState:UIControlStateNormal];
//        [sharebtn addTarget:self action:@selector(clickShareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sharebtn];
    
    
            
    UIButton *mall = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(sharebtn.frame) - 5 - 25.5, kStatusBarHeight, 25.5, 44)];
    mall.showsTouchWhenHighlighted = NO;
    [mall setImage:[UIImage imageNamed:@"store_ information"] forState:UIControlStateNormal];
//        [sharebtn addTarget:self action:@selector(clickShareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mall];
    
    UITextField *searchTextField = [[UITextField alloc] init];
    searchTextField.backgroundColor = [UIColor colorWithHexString:@"F5F6FA"];
    searchTextField.layer.cornerRadius = HScaleHeight(14);
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.font = HScaleFont(12);
    searchTextField.textColor = [UIColor colorWithHexString:@"999999"];
    searchTextField.placeholder = @"瓷砖";
    searchTextField.userInteractionEnabled = YES;
    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
    searchTextField.layer.shadowOpacity = 1;
    searchTextField.layer.shadowRadius = 4;

    
    searchTextField.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];

    [self.view addSubview:searchTextField];
    
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(35), HScaleHeight(28))];
    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
    searchIconImageView.size = CGSizeMake(HScaleWidth(15), HScaleHeight(15));
    [leftview addSubview:searchIconImageView];
    searchIconImageView.center = leftview.center;

    searchTextField.leftView = leftview;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(41.5));
        make.height.mas_equalTo(HScaleHeight(28));
        make.width.mas_equalTo(HScaleWidth(250));
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        
    }];
}

- (void)getStoreDetail
{
    NSString *ursStr = [NSString stringWithFormat:@"%@/%@",ShopStore,self.store_id];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ursStr withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {

            self.shop_model = [[DFStoreModel alloc]initWithDictionary:response[@"data"] error:nil];
            
            DFStoreHeaderView *headerview = [[DFStoreHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(300.5)+kStatusBarHeight) withModel:self.shop_model];
            headerview.selectTypeBtn = ^(NSInteger type, NSString * _Nonnull titleText) {
                
                [self.goods_arry removeAllObjects];
                self.selectType = type;

                
                if (type == 0) {
                    [self getShopGoodsWithType:0];
                }
                else if (type == 1)
                {
                    [self getShopGoodsWithType:1];

                }
                else if (type == 2)
                {
                    
                    if ([titleText isEqualToString:@"价格↓"]) {
                        [self getShopGoodsWithType:3];

                    }
                    else
                    {
                        [self getShopGoodsWithType:2];

                    }
                    

                }
                else if (type == 3)
                {
                    [self getShopGoodsWithType:4];

                }
                

            };
            [self.view addSubview:headerview];
            
            [self creatNavView];
            
            [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(headerview.mas_bottom).offset(HScaleHeight(10));
                make.bottom.mas_equalTo(- kBottomSafeHeight);
            }];
            
            [self getShopGoodsWithType:0];

        }
            
    }];
}

- (void)getMoreData
{
    [self getShopGoodsWithType:self.selectType];
}

- (void)getShopGoodsWithType:(NSInteger)type
{
    
    [SVProgressHUD showWithStatus:@"加载中。。。"];
    
    NSMutableDictionary *parmars = [@{@"shop_id":self.store_id,@"des_status":@(type),@"itemsPerLoad":@"10",@"lastIndex":@(self.goods_arry.count)}copy];
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ShopGoods withParameter:parmars withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            
            NSArray *dataarry = response[@"data"];
            for (NSInteger index = 0; index < dataarry.count; index ++) {
                DFStoreGoodModel *model = [[DFStoreGoodModel alloc]initWithDictionary:dataarry[index] error:nil];
                
                [self.goods_arry addObject:model];

            }
            
            if (dataarry.count > 0) {
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
- (void)clickCancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
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

    DFStoreDetailGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFStoreDetailGoodsCell" forIndexPath:indexPath];
    cell.model = self.goods_arry[indexPath.row];
    
     
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    DFStoreGoodModel *model = self.goods_arry[indexPath.row];
    DFGoodsDetailViewController *goodsDetail = [[DFGoodsDetailViewController alloc]init];
    goodsDetail.goods_id = model.spu_id;
    [self.navigationController pushViewController:goodsDetail animated:YES];
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
- (NSMutableArray *)goods_arry
{
    if (!_goods_arry) {
        _goods_arry = [NSMutableArray arrayWithCapacity:0];
    }
    return _goods_arry;
}
- (UICollectionView *)scrollView
{
    if (!_scrollView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

         
         // 创建collectionView
         _scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight + HScaleHeight(47), ScreenW ,ScreenH - kNavAndTabHeight - HScaleHeight(47))collectionViewLayout:layout];
         _scrollView.backgroundColor = [UIColor whiteColor];
         _scrollView.delegate = self;
         _scrollView.dataSource = self;
         _scrollView.showsVerticalScrollIndicator = NO;
         _scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _scrollView.alwaysBounceVertical = YES;
        [_scrollView registerClass:[DFStoreDetailGoodsCell class] forCellWithReuseIdentifier:@"DFStoreDetailGoodsCell"];
        
        _scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
        
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
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
