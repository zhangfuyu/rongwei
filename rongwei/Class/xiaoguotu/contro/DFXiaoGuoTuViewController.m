//
//  DFXiaoGuoTuViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFXiaoGuoTuViewController.h"
#import "DFRenderingNarbarView.h"
#import "CQTopBarSegment.h"
#import "DFWaterFallLayout.h"
#import "DFRenderingCollectionViewCell.h"
#import "DFDesignerWorkModel.h"
#import "DFWorksDetailViewController.h"
#import "DFLookMorePictureViewController.h"
#import "DFHomeWorkListCell.h"
#import "DFXiaoGuoStyleViewController.h"
#import "DFYuSuanViewController.h"
#import "DFAreaViewController.h"
#import "DFDecorateFamilyViewController.h"

@interface DFXiaoGuoTuViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,CQTopBarSegmentDelegate,DFXiaoGuoStyleViewControllerDelegate,DFYuSuanViewControllerDelegate,DFAreaViewControllerDelegate,DFDecorateFamilyViewControllerDelegate>
@property (nonatomic , strong)DFRenderingNarbarView *navview;
@property (nonatomic , strong)CQTopBarSegment *segment;

@property (nonatomic , strong)CQTopBarSegment *segment2;
@property (nonatomic , strong)NSMutableDictionary *parmars;

@property (nonatomic , strong)DFXiaoGuoStyleViewController *stylevc;

@property (nonatomic , strong)DFYuSuanViewController *yusuanVc;

@property (nonatomic , strong)DFAreaViewController *areaVC;

@property (nonatomic , strong)DFDecorateFamilyViewController *DecorateFamily;


@property (nonatomic , strong)UICollectionView *scrollView;
@property (nonatomic , strong)NSMutableArray *work_listArry;

@end

@implementation DFXiaoGuoTuViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)hiddenStyleView
{

    self.stylevc.view.hidden = YES;
    self.yusuanVc.view.hidden = YES;
    self.areaVC.view.hidden = YES;
    self.DecorateFamily.view.hidden = YES;
    
    [self.view bringSubviewToFront:self.DecorateFamily.view];
    [self.view bringSubviewToFront:self.stylevc.view];
    [self.view bringSubviewToFront:self.yusuanVc.view];
    [self.view bringSubviewToFront:self.areaVC.view];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"效果图";
    self.parmars = [[NSMutableDictionary alloc]init];
    self.parmars[@"is_rec"] = @"0";
    
    [self.navview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
    WEAKSELF;
    self.navview.chooseConditionsBlock = ^(DFconditions conditon) {
        
        
        [weakSelf hiddenStyleView];
        if (conditon == DFconditions_DecorateACase) {
            [weakSelf.view bringSubviewToFront:weakSelf.segment2];
            [weakSelf.segment2.collectionView reloadData];
            [weakSelf.view bringSubviewToFront:weakSelf.dataTableview];
            weakSelf.parmars[@"is_rec"] = @"1";
        }
        else
        {
            weakSelf.parmars[@"is_rec"] = @"0";
            [weakSelf.view bringSubviewToFront:weakSelf.segment];
            [weakSelf.segment.collectionView reloadData];
            [weakSelf.view bringSubviewToFront:weakSelf.scrollView];
        }
        
        
        [weakSelf.work_listArry removeAllObjects];
        [weakSelf getWorkData];
    };
    [self.view addSubview:self.segment2];
    [self.view addSubview:self.segment];
    
    
    
    [self allocTableviewWith:UITableViewStylePlain];
    self.dataTableview.delegate = self;
    self.dataTableview.dataSource = self;
    self.dataTableview.separatorColor = [UIColor clearColor];
    self.dataTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getWorkData)];

    
    [self.dataTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(47));
        make.bottom.mas_equalTo(-kTabBarHeight);
    }];
    
    
    
    
    
    // 创建布局
    // 1.创建流水布局
   UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
   layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    
    // 创建collectionView
    self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight + HScaleHeight(47), ScreenW ,ScreenH - kNavAndTabHeight - HScaleHeight(47))collectionViewLayout:layout];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.dataSource = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        
    self.scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getWorkData)];

        
    [self.scrollView registerClass:[DFRenderingCollectionViewCell class] forCellWithReuseIdentifier:@"DFRenderingCollectionViewCell"];
    
    [self.view addSubview:self.scrollView];
    
    [self getWorkData];
    
}

/// 推荐案例
- (void)getWorkData
{
    
    [SVProgressHUD showWithStatus:@"正在加载。。。"];
    
    self.parmars[@"itemsPerLoad"] = @"10";
    self.parmars[@"lastIndex"] = @(self.work_listArry.count);
    
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:WorkDesignerDetailApi withParameter:self.parmars withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
           if (isSuccess) {
               
              NSArray *listarry = response[@"data"];
              if (listarry.count > 0) {
                  for (NSDictionary *dic in listarry) {
                      DFDesignerWorkModel *workmodel = [[DFDesignerWorkModel alloc]initWithDictionary:dic error:nil];
                      [self.work_listArry addObject:workmodel];
                  }
              }
               if ([self.parmars[@"is_rec"] intValue] == 1) {
                   [self.dataTableview reloadData];
               }
               else
               {
                   [self.scrollView reloadData];

               }
               
               if (listarry.count == 0) {
                   [self.scrollView.mj_footer endRefreshingWithNoMoreData];
                   [self.dataTableview.mj_footer endRefreshingWithNoMoreData];

               }
               
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
    return self.work_listArry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFRenderingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFRenderingCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.work_listArry[indexPath.row];
    
     
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DFDesignerWorkModel *model = self.work_listArry[indexPath.row];
    if (model.work_images.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"暂无图片"];
        return;
    }
    DFLookMorePictureViewController *lookMorePicture =[[DFLookMorePictureViewController alloc]init];
    lookMorePicture.model = model;
    [self.navigationController pushViewController:lookMorePicture animated:YES];
    
}
// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 35.0f;
//    CGFloat width = [self gainStringWidthWithString:self.nameArray[indexPath.row] font:15.0f height:height];
    return CGSizeMake((ScreenW - HScaleWidth(30)) / 2, HScaleHeight(126));
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.work_listArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cellidear = @"DFHomeWorkListCell";
    DFHomeWorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidear];
    if (!cell) {
        cell = [[DFHomeWorkListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidear];
    }
    cell.model = self.work_listArry[indexPath.row];
    cell.isRecommended = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScaleHeight(222);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DFDesignerWorkModel *model = self.work_listArry[indexPath.row];
    DFWorksDetailViewController *worksdetail = [[DFWorksDetailViewController alloc]init];
    worksdetail.worksId = model.modelid;
//        worksdetail.model = self.model;
    worksdetail.autherID = model.designer_id;
    [self.navigationController pushViewController:worksdetail animated:YES];
    
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//
//    DFDesignerWorkModel *model = self.work_listArry[indexPath.row];
//    DFWorksDetailViewController *worksdetail = [[DFWorksDetailViewController alloc]init];
//    worksdetail.worksId = model.modelid;
////        worksdetail.model = self.model;
//    worksdetail.autherID = model.designer_id;
//    [self.navigationController pushViewController:worksdetail animated:YES];
//
//}
///***********************************/
//#pragma mark  - <LMHWaterFallLayoutDeleaget>
//- (CGFloat)waterFallLayout:(DFWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
//
//
//    return HScaleHeight(126);
//}
//
//- (CGFloat)rowMarginInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout {
//
//    return HScaleWidth(10);
//
//}
//
//- (CGFloat)columnMarginInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout {
//
//    return HScaleWidth(10);
//
//}
//
//- (NSUInteger)columnCountInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout{
//
//    return 2;
//
//}
//#pragma mark - UICollectionViewDelegate
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//
//    return 1;
//
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//
//    return 2;
//
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    DFRenderingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFRenderingCollectionViewCell" forIndexPath:indexPath];
//
//
//
//    return cell;
//
//}
#pragma mark - DFXiaoGuoStyleViewControllerDelegate
- (void)selectChooseStyleId:(NSString *)styleId withText:(nonnull NSString *)text
{
    
    
    
    [self.segment.collectionView reloadData];
    [self.segment2.collectionView reloadData];
    
    if (styleId.length == 0) {
        return;
    }
    
    text = [text stringByReplacingOccurrencesOfString:@"不限" withString:@"风格"];
    
    NSString * isrex = self.parmars[@"is_rec"];

    
    if ([isrex intValue] == 1) {
        [self.segment2 topBarReplaceObjectsAtIndexes:0 withObjects:text BarView:nil];

    }
    else
    {
        [self.segment topBarReplaceObjectsAtIndexes:0 withObjects:text BarView:nil];

    }
    
    self.stylevc.view.hidden = YES;
    self.parmars[@"style_id"] = styleId;
    [self.work_listArry removeAllObjects];
    [self getWorkData];
}
- (void)selectChooseBudgetStyleId:(NSString *)styleId withText:(nonnull NSString *)text
{
    [self.segment.collectionView reloadData];
    [self.segment2.collectionView reloadData];
    
    if (styleId.length == 0) {
        return;
    }
    
    text = [text stringByReplacingOccurrencesOfString:@"不限" withString:@"预算"];
    
    NSString * isrex = self.parmars[@"is_rec"];
    
    if ([isrex intValue] == 1) {
        [self.segment2 topBarReplaceObjectsAtIndexes:2 withObjects:text BarView:nil];

    }
    else
    {
        [self.segment topBarReplaceObjectsAtIndexes:2 withObjects:text BarView:nil];

    }
    
    self.stylevc.view.hidden = YES;
    self.parmars[@"budget"] = styleId;
    
    [self.work_listArry removeAllObjects];
    [self getWorkData];
}
- (void)selectChooseAreaStyleId:(NSString *)styleId withText:(NSString *)text
{
   
    [self.segment.collectionView reloadData];
    [self.segment2.collectionView reloadData];
    
    if (styleId.length == 0) {
        return;
    }
    
    text = [text stringByReplacingOccurrencesOfString:@"不限" withString:@"面积"];
    
    [self.segment2 topBarReplaceObjectsAtIndexes:3 withObjects:text BarView:nil];

    
    self.stylevc.view.hidden = YES;
    self.parmars[@"mianji"] = styleId;
    [self.work_listArry removeAllObjects];
    [self getWorkData];
}

- (DFRenderingNarbarView *)navview
{
    if (!_navview) {
        _navview = [[DFRenderingNarbarView alloc]init];
        [self.view addSubview:_navview];
    }
    return _navview;
}

- (CQTopBarSegment *)segment
{
    if (!_segment) {
        _segment = [[CQTopBarSegment alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(47)) sectionTitles:@[@"风格",@"户型",@"预算"]];
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

- (CQTopBarSegment *)segment2
{
    if (!_segment2) {
        _segment2 = [[CQTopBarSegment alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, ScreenW, HScaleHeight(47)) sectionTitles:@[@"风格",@"户型",@"预算",@"面积"]];
        _segment2.titleTextColor = [UIColor colorWithHexString:@"666666"];
        _segment2.segmentImage = @"箭头";
        _segment2.delegate = self;
        _segment2.selectSegmentImage = @"箭头-1";
        _segment2.selectedTitleTextColor = [UIColor colorWithHexString:@"DD1A21"];
        _segment2.titleTextFont = HScaleFont(12);
        _segment2.segmentlineColor = [UIColor clearColor];
    }
    return _segment2;
}
- (void)topBarSegmentWithBlock:(CQTopBarSegment *)segment indexPath:(NSIndexPath *)indexPath
{
    
    [self hiddenStyleView];

    if (indexPath.row == 0) {
            self.stylevc.view.hidden = !self.stylevc.view.hidden;

    }
    else if (indexPath.row == 1)
    {
        self.DecorateFamily.view.hidden = !self.DecorateFamily.view.hidden;
    }
    else if (indexPath.row == 2)
    {
        self.yusuanVc.view.hidden = !self.yusuanVc.view.hidden;
    }
    else if (indexPath.row == 3)
    {
        self.areaVC.view.hidden = !self.areaVC.view.hidden;

    }
    
}
- (void)topBarSegmentWithSegmentView:(CQTopBarSegment *)segmentView;
{

    [self hiddenStyleView];

}


- (NSMutableArray *)work_listArry
{
    if (!_work_listArry) {
        _work_listArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _work_listArry;
}

- (DFXiaoGuoStyleViewController *)stylevc
{
    if (!_stylevc) {
        _stylevc = [[DFXiaoGuoStyleViewController alloc]init];
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

- (DFYuSuanViewController *)yusuanVc
{
    if (!_yusuanVc) {
        _yusuanVc = [[DFYuSuanViewController alloc]init];
        _yusuanVc.delegate = self;
        _yusuanVc.view.hidden = YES;
        [self addChildViewController:_yusuanVc];
        [self.view addSubview:_yusuanVc.view];
        
        [_yusuanVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(47));
        }];
        
    }
    return _yusuanVc;
}

- (DFAreaViewController *)areaVC
{
    if (!_areaVC) {
        _areaVC = [[DFAreaViewController alloc]init];
        _areaVC.delegate = self;
        _areaVC.view.hidden = YES;
        [self addChildViewController:_areaVC];
        [self.view addSubview:_areaVC.view];
        [_areaVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(kNavBarAndStatusBarHeight + HScaleHeight(47));
        }];
        
    }
    return _areaVC;
}

- (DFDecorateFamilyViewController *)DecorateFamily
{
    if (!_DecorateFamily) {
        _DecorateFamily = [[DFDecorateFamilyViewController alloc]init];
        _DecorateFamily.delegate = self;
        _DecorateFamily.view.hidden = YES;
        [self addChildViewController:_DecorateFamily];
        [self.view addSubview:_DecorateFamily.view];
    }
    return _DecorateFamily;
}

- (void)selectChooseDoorModelStyleId:(NSString *)styleId withText:(NSString *)text
{

    
    if (text.length == 0) {
        return;
    }
    
    text = [text stringByReplacingOccurrencesOfString:@"不限" withString:@"户型"];
    NSString * isrex = self.parmars[@"is_rec"];
    
    if ([isrex intValue] == 1) {
        [self.segment2 topBarReplaceObjectsAtIndexes:1 withObjects:text BarView:nil];

    }
    else
    {
        [self.segment topBarReplaceObjectsAtIndexes:1 withObjects:text BarView:nil];

    }
    
    [self.segment.collectionView reloadData];
    [self.segment2.collectionView reloadData];

    self.parmars[@"shape_id"] = styleId;

    self.DecorateFamily.view.hidden = YES;
    [self.segment.collectionView reloadData];
    [self.segment2.collectionView reloadData];

    
    [self.work_listArry removeAllObjects];
    [self getWorkData];
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
