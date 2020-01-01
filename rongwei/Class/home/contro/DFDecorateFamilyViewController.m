//
//  DFDecorateFamilyViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/24.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFDecorateFamilyViewController.h"
#import "DFXiaoGuoStyleCell.h"

@interface DFDecorateFamilyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong)NSMutableArray *styleArry;

@property (nonatomic , strong)UICollectionView *scrollView;

@property (nonatomic , strong)NSIndexPath *selecIndex;

@property (nonatomic , assign)BOOL isSelect;


@end

@implementation DFDecorateFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        self.isSelect = YES;
    self.selecIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.styleArry = [NSMutableArray arrayWithCapacity:0];
    
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(HScaleWidth(0),kNavBarAndStatusBarHeight + HScaleHeight(47),ScreenW,HScaleHeight(15));
    label.backgroundColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"    装修户型" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];

    label.attributedText = string;
    
         // 创建布局
         // 1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

     
     // 创建collectionView
     self.scrollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight + HScaleHeight(47) + HScaleHeight(15), ScreenW ,HScaleHeight(70))collectionViewLayout:layout];
     self.scrollView.backgroundColor = [UIColor whiteColor];
     self.scrollView.delegate = self;
     self.scrollView.dataSource = self;
     self.scrollView.showsVerticalScrollIndicator = NO;
     self.scrollView.alwaysBounceVertical = YES;
//     self.scrollView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    
        
    [self.scrollView registerClass:[DFXiaoGuoStyleCell class] forCellWithReuseIdentifier:@"DFXiaoGuoStyleCell"];
    
    [self.view addSubview:self.scrollView];
    
    [self getData];

}

- (void)getData
{
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:ConstructionShapes withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:NO withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
 
            NSArray *dataArry = response[@"data"];
            self.styleArry = [NSMutableArray arrayWithArray:dataArry];
            NSDictionary *dic = @{@"id":@"0",
                                  @"name":@"不限",
                                  @"sort":@"1"
            };
            [self.styleArry insertObject:dic atIndex:0];
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
    return self.styleArry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFXiaoGuoStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFXiaoGuoStyleCell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.styleArry[indexPath.row];
    cell.titeleTextk = dic[@"name"];
    
    if (self.isSelect) {
        if (self.selecIndex.row == indexPath.row) {
            cell.isSelect = YES;
        }
        else
        {
            cell.isSelect = NO;
        }
    }
     
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.isSelect = YES;
    self.selecIndex = indexPath;
    [collectionView reloadData];
    self.view.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseDoorModelStyleId:withText:)]) {
        NSDictionary *dic = self.styleArry[indexPath.row];
        [self.delegate selectChooseDoorModelStyleId:dic[@"id"] withText:dic[@"name"]];
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
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectChooseDoorModelStyleId:withText:)]) {
            [self.delegate selectChooseDoorModelStyleId:@"" withText:@""];
        }
    }
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
