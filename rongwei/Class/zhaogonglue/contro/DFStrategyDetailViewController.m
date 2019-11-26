//
//  DFStrategyDetailViewController.m
//  rongwei
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyDetailViewController.h"
#import "DFGongLueModel.h"
#import "DFStrategyDetailHeaderView.h"
#import "DFItsCollectionViewCell.h"

@interface DFStrategyDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) DFGongLueModel *model;

@property (nonatomic , strong) UICollectionView *scrollView;


@end

@implementation DFStrategyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getdata];
    
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(HScaleWidth(0), 0, ScreenW - HScaleWidth(0), ScreenH - kBottomSafeHeight )collectionViewLayout:layout];
        [self.scrollView registerClass:[DFItsCollectionViewCell class] forCellWithReuseIdentifier:@"DFItsCollectionViewCell"];
            /// 设置此属性为yes 不满一屏幕 也能滚动
        self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    //        _collectionview.alwaysBounceHorizontal = YES;
        self.scrollView.alwaysBounceVertical = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.dataSource = self;
        [self.view addSubview:self.scrollView];
    

}
#pragma mark - 代理方法 Delegate Methods
// 设置分区

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 11;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFItsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DFItsCollectionViewCell class]) forIndexPath:indexPath];
//    [cell refreshCellWithTitle:self.nameArray[indexPath.row]];
//    cell.model = self.dataArry[indexPath.row];
    return cell;
}

// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 35.0f;
//    CGFloat width = [self gainStringWidthWithString:self.nameArray[indexPath.row] font:15.0f height:height];
    return CGSizeMake(HScaleWidth(172.5), HScaleHeight(135.5));
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
- (void)getdata
{
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",BbsGuide,self.modelid];
    
    
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:urlstr withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            
            self.model = [[DFGongLueModel alloc]initWithDictionary:response[@"data"] error:nil];
            DFStrategyDetailHeaderView *headervew = [[DFStrategyDetailHeaderView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, ScreenW, HScaleHeight(370 + 5 + 300)) withModel:self.model];
            self.scrollView.col

        }
    }];
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
