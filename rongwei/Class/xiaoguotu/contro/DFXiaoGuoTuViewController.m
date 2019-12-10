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

@interface DFXiaoGuoTuViewController ()<DFWaterFallLayoutDeleaget, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic , strong)DFRenderingNarbarView *navview;
@property (nonatomic , strong)CQTopBarSegment *segment;

@property (nonatomic , strong)UICollectionView *scrollView;
@property (nonatomic , strong)NSMutableArray *work_listArry;

@end

@implementation DFXiaoGuoTuViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"效果图";
    [self.navview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
    [self.view addSubview:self.segment];
    
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
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        
        
        
    [self.scrollView registerClass:[DFRenderingCollectionViewCell class] forCellWithReuseIdentifier:@"DFRenderingCollectionViewCell"];
    
    [self.view addSubview:self.scrollView];
    
    [self getWorkData];
    
}

/// 推荐案例
- (void)getWorkData
{
    
    [SVProgressHUD showWithStatus:@"正在加载。。。"];
    NSMutableDictionary *parmar = [@{
        @"is_rec":@"1",

    }copy];
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:WorkDesignerDetailApi withParameter:parmar withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
           if (isSuccess) {
               
              NSArray *listarry = response[@"data"];
              if (listarry.count > 0) {
                  for (NSDictionary *dic in listarry) {
                      DFDesignerWorkModel *workmodel = [[DFDesignerWorkModel alloc]initWithDictionary:dic error:nil];
                      [self.work_listArry addObject:workmodel];
                  }
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
    return self.work_listArry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFRenderingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFRenderingCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.work_listArry[indexPath.row];
    
     
    return cell;
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DFDesignerWorkModel *model = self.work_listArry[indexPath.row];
    DFWorksDetailViewController *worksdetail = [[DFWorksDetailViewController alloc]init];
    worksdetail.worksId = model.modelid;
//        worksdetail.model = self.model;
    worksdetail.autherID = model.designer_id;
    [self.navigationController pushViewController:worksdetail animated:YES];

}
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
        _segment.selectSegmentImage = @"箭头-1";
        _segment.selectedTitleTextColor = [UIColor colorWithHexString:@"DD1A21"];
        _segment.titleTextFont = HScaleFont(12);
        _segment.segmentlineColor = [UIColor clearColor];
    }
    return _segment;
}

- (NSMutableArray *)work_listArry
{
    if (!_work_listArry) {
        _work_listArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _work_listArry;
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
