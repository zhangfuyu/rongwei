//
//  DFXiaoGuoStyleViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFXiaoGuoStyleViewController.h"
#import "DFXiaoGuoStyleCell.h"

@interface DFXiaoGuoStyleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong)NSMutableArray *styleArry;

@property (nonatomic , strong)UICollectionView *scrollView;

@end

@implementation DFXiaoGuoStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    
     // 创建布局
     // 1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

     
     // 创建collectionView
     self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW ,HScaleHeight(200))collectionViewLayout:layout];
     self.scrollView.backgroundColor = [UIColor whiteColor];
     self.scrollView.delegate = self;
     self.scrollView.dataSource = self;
     self.scrollView.showsVerticalScrollIndicator = NO;
     self.scrollView.alwaysBounceVertical = YES;
//     self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    
        
    [self.scrollView registerClass:[DFXiaoGuoStyleCell class] forCellWithReuseIdentifier:@"DFXiaoGuoStyleCell"];
    
    [self.view addSubview:self.scrollView];
    
    [self getStyle];
}
- (void)getStyle
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:WorkDesignerStyleApi withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
       if (isSuccess) {
           NSArray *dataArry = response[@"data"];
           self.styleArry = [NSMutableArray arrayWithArray:dataArry];
           dispatch_async(dispatch_get_main_queue(), ^{
               [self.scrollView reloadData];
           });
           
           
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
    return self.styleArry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFXiaoGuoStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFXiaoGuoStyleCell" forIndexPath:indexPath];
    NSDictionary *dic = self.styleArry[indexPath.row];
    cell.titeleTextk = dic[@"name"];
     
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.styleArry[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseStyleId:)]) {
        [self.delegate selectChooseStyleId:[NSString stringWithFormat:@"%@",dic[@"id"]]];
    }
}
// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 35.0f;
//    CGFloat width = [self gainStringWidthWithString:self.nameArray[indexPath.row] font:15.0f height:height];
    return CGSizeMake((ScreenW - HScaleWidth(60)) / 4, HScaleHeight(25));
}


// 设置UIcollectionView整体的内边距（这样item不贴边显示）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section % 4 > 0) {
        
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view) {
        self.view.hidden = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseStyleId:)]) {
            [self.delegate selectChooseStyleId:@""];
        }
    }
}

- (NSMutableArray *)styleArry
{
    if (!_styleArry) {
        _styleArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _styleArry;
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