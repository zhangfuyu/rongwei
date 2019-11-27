//
//  DFRecommendedViewController.m
//  rongwei
//
//  Created by apple on 2019/11/27.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFRecommendedViewController.h"
#import "DFGongLueModel.h"
#import "DFStrategyCollectionViewCell.h"
#import "DFStrategyDetailViewController.h"

@interface DFRecommendedViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , strong) NSMutableArray *dataArry;



@end

@implementation DFRecommendedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArry = [NSMutableArray arrayWithCapacity:0];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(HScaleWidth(10), 0, ScreenW - HScaleWidth(20), ScreenH)collectionViewLayout:layout];
    [self.scrollView registerClass:[DFStrategyCollectionViewCell class] forCellWithReuseIdentifier:@"DFStrategyCollectionViewCell"];
        /// 设置此属性为yes 不满一屏幕 也能滚动
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
//        _collectionview.alwaysBounceHorizontal = YES;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.dataSource = self;
    [self.view addSubview:self.scrollView];
    
    [self getrecommended];
}
- (void)getrecommended
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:BbsGuide withParameter:@{@"is_rec":@"0"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *dataArry = response[@"data"];
            if (dataArry.count > 0) {
                for (NSDictionary *dic in dataArry) {
                    DFGongLueModel *submodel = [[DFGongLueModel alloc]initWithDictionary:dic error:nil];
                    [self.dataArry addObject:submodel];
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
    return self.dataArry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFStrategyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DFStrategyCollectionViewCell class]) forIndexPath:indexPath];
//    [cell refreshCellWithTitle:self.nameArray[indexPath.row]];
    cell.model = self.dataArry[indexPath.row];
    return cell;
}

// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 35.0f;
//    CGFloat width = [self gainStringWidthWithString:self.nameArray[indexPath.row] font:15.0f height:height];
    return CGSizeMake(HScaleWidth(172.5), HScaleHeight(125.5));
}


// 设置UIcollectionView整体的内边距（这样item不贴边显示）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 上 左 下 右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 设置minimumLineSpacing：cell上下之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return HScaleHeight(0);
}

// 设置minimumInteritemSpacing：cell左右之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return HScaleHeight(0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DFGongLueModel *model = self.dataArry[indexPath.row];
    DFStrategyDetailViewController *detail = [[DFStrategyDetailViewController alloc]init];
    detail.modelid = model.modelId;
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
//    self.scrollView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
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
