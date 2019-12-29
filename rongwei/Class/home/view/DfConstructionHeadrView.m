//
//  DfConstructionHeadrView.m
//  rongwei
//
//  Created by apple on 2019/11/20.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DfConstructionHeadrView.h"
#import "DFConstructionCell.h"
#import "DFContructionWorkDetailViewController.h"
@interface DfConstructionHeadrView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UIImageView *imageview;

@property (nonatomic , strong) UICollectionView *collectionview;

@end

@implementation DfConstructionHeadrView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.frame = CGRectMake(0, 0, ScreenW, HScaleHeight(220));
        
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(136.5));
        }];
        
        
        NSArray *arry = [NSArray arrayWithObjects:@"先施工在支付",@"工地全程记录",@"施工过程透明", nil];
        
        CGFloat interval = (ScreenW - HScaleHeight(20) - HScaleWidth(105.5)  *3 ) / 2;
        
        for (NSInteger index = 0; index < arry.count; index ++) {
            UILabel *sublabel = [[UILabel alloc]init];
            sublabel.text = arry[index];
            sublabel.backgroundColor = [UIColor colorWithHexString:@"FCE8E8"];
            sublabel.layer.cornerRadius = HScaleHeight(19.5) / 2;
            sublabel.layer.masksToBounds = YES;
            sublabel.textColor = [UIColor colorWithHexString:@"E69D9F"];
            sublabel.font = HScaleFont(11);
            sublabel.textAlignment = NSTextAlignmentCenter;
            sublabel.frame = CGRectMake(HScaleWidth(10) + index % 3 * interval + index * HScaleWidth(105.5), HScaleHeight(152), HScaleWidth(105.5), HScaleHeight(19.5));
            [self addSubview: sublabel];
        }
        
        [self addSubview:self.collectionview];
        
        NSArray *backgroundColor = [NSArray arrayWithObjects:@"F5DDDE",@"DFF6E0",@"DCF3F8",@"EAEFC9",@"EFD5C9", nil];
        NSArray *titleColor = [NSArray arrayWithObjects:@"DD1A21",@"00B408",@"009BBD",@"B0B200",@"C93F00", nil];
        NSArray *titlearry = [NSArray arrayWithObjects:@"水电阶段 ",@"泥工阶段 ",@"木工阶段 ",@"油漆阶段",@"保洁修补", nil];

        for (NSInteger index = 0; index < titlearry.count; index ++) {
            UILabel *sublabel = [[UILabel alloc]init];
            sublabel.text = titlearry[index];
            sublabel.backgroundColor = [UIColor colorWithHexString:backgroundColor[index]];
            sublabel.layer.cornerRadius = HScaleHeight(1.5);
            sublabel.layer.masksToBounds = YES;
            sublabel.textColor = [UIColor colorWithHexString:titleColor[index]];
            sublabel.font = HScaleFont(9);
            sublabel.textAlignment = NSTextAlignmentCenter;
            sublabel.frame = CGRectMake((index + 1) * HScaleWidth(10) + index * HScaleWidth(45), HScaleHeight(322), HScaleWidth(45), HScaleHeight(15));
            [self addSubview: sublabel];
        }

        
    }
    return self;
}
- (void)setDataArry:(NSMutableArray *)dataArry
{
    _dataArry = dataArry;
    [self.collectionview reloadData];
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

    DFConstructionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DFConstructionCell class]) forIndexPath:indexPath];
//    [cell refreshCellWithTitle:self.nameArray[indexPath.row]];
    cell.model = self.dataArry[indexPath.row];
    return cell;
}

// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 35.0f;
//    CGFloat width = [self gainStringWidthWithString:self.nameArray[indexPath.row] font:15.0f height:height];
    return CGSizeMake(HScaleWidth(100), HScaleHeight(140));
}


// 设置UIcollectionView整体的内边距（这样item不贴边显示）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 上 左 下 右
    return UIEdgeInsetsMake(0, 0, 0, 0);
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
    DFConstructionModel *model = self.dataArry[indexPath.row];
    DFContructionWorkDetailViewController *detail = [[DFContructionWorkDetailViewController alloc]init];
    detail.contructionWork_ID = model.modelid;
    [self.viewController.navigationController pushViewController:detail animated:YES];
}

- (UIImageView *)imageview
{
    if (!_imageview ) {
        _imageview = [[UIImageView alloc]init];
        _imageview.image = [UIImage imageNamed:@"Construction_pic"];
        [self addSubview:_imageview];
    }
    return _imageview;
}
- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        
        // 1.创建流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(HScaleWidth(10), HScaleHeight(181), ScreenW - HScaleWidth(20), HScaleHeight(140))collectionViewLayout:layout];
        [_collectionview registerClass:[DFConstructionCell class] forCellWithReuseIdentifier:@"DFConstructionCell"];
            /// 设置此属性为yes 不满一屏幕 也能滚动
        _collectionview.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _collectionview.alwaysBounceHorizontal = YES;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
   
    }
    return _collectionview;
 
}
@end
