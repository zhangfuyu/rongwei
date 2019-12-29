//
//  DFConfigurationView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/15.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFConfigurationView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "DFStandardCollectionViewCell.h"
#import "DFStandardCollectionReusableView.h"
#import "DFChildModel.h"
@interface DFConfigurationView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) NSMutableArray *dataArry;
@property (nonatomic , strong) UIView *backWhierView;
@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , strong) DFGoodsDetailModel *detailModel;
@property (nonatomic , strong) NSMutableArray *array_selectedModel;

@property (nonatomic , strong) UILabel *payNumberLabel;


@end

@implementation DFConfigurationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame WithModel:(DFGoodsDetailModel *)model
{
    if (self = [super initWithFrame:frame]) {
        
        self.detailModel = model;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4];
        NSArray *specArry =[NSMutableArray arrayWithArray:model.spec];
        
        [self getSpecModel:specArry];
        
        
        self.backWhierView = [[UIView alloc]init];
        self.backWhierView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:self.backWhierView];
        
        [self.backWhierView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(ScreenH / 3 * 2);
        }];
        
        UIImageView *imageview = [[UIImageView alloc]init];
        [imageview sd_setImageWithURL:[NSURL URLWithString:model.goods_thumb] placeholderImage:nil];
        [self addSubview:imageview];
        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(15));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(110), HScaleHeight(110)));
            make.centerY.mas_equalTo(self.backWhierView.mas_top);
        }];
        
        UILabel *lowprice = [[UILabel alloc]init];
        lowprice.textColor = [UIColor colorWithHexString:@"DD1A21"];
        lowprice.font = HScaleBoldFont(12);
        [self.backWhierView addSubview:lowprice];
        
        lowprice.text = [NSString stringWithFormat:@"￥%@",model.low_price];
        
        [lowprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(140));
            make.top.mas_equalTo(HScaleHeight(17));
        }];
        
        UILabel *theTitle = [[UILabel alloc]init];
        theTitle.textColor = [UIColor colorWithHexString:@"333333"];
        theTitle.font = HScaleBoldFont(12);
        [self.backWhierView addSubview:theTitle];
        
        theTitle.text = @"请选择规格数量";
        
        [theTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lowprice.mas_left);
            make.top.mas_equalTo(lowprice.mas_bottom).offset(HScaleHeight(8.5));
        }];
        
        
        [self.backWhierView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(HScaleHeight(55));
            make.bottom.mas_equalTo(- HScaleHeight(145));
        }];
        
        
        
        
        UILabel *payNumber = [[UILabel alloc]init];
        payNumber.textColor = [UIColor colorWithHexString:@"333333"];
        payNumber.font = HScaleBoldFont(12);
        [self.backWhierView addSubview:payNumber];
        
        payNumber.text = @"购买数量";
        
        [payNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(14.5));
            make.top.mas_equalTo(self.collectionView.mas_bottom).offset(HScaleHeight(19));
        }];
        
        
        
        UIButton *btn_Add = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_Add setBackgroundColor:[UIColor colorWithHexString:@"F5F5F5"]];
        btn_Add.layer.cornerRadius = HScaleHeight(2.5);
        [btn_Add setImage:[UIImage imageNamed:@"add_goods"] forState:UIControlStateNormal];
        [btn_Add addTarget:self action:@selector(payNumberLabelAdd) forControlEvents:UIControlEventTouchUpInside];

        [self.backWhierView addSubview:btn_Add];
        
        [btn_Add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(21.5));
            make.centerY.mas_equalTo(payNumber.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(27), HScaleHeight(27)));
        }];
        
        
        
        self.payNumberLabel = [[UILabel alloc]init];
        self.payNumberLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.payNumberLabel.font = HScaleBoldFont(15);
        self.payNumberLabel.layer.cornerRadius = HScaleHeight(2.5);

        self.payNumberLabel.textAlignment = NSTextAlignmentCenter;
        self.payNumberLabel.backgroundColor =[UIColor colorWithHexString:@"F5F5F5"];
        [self.backWhierView addSubview:self.payNumberLabel];
        
        self.payNumberLabel.text = @"1";
        
        [self.payNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(btn_Add.mas_left).offset(-HScaleWidth(1.5));
            make.centerY.mas_equalTo(payNumber.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(27), HScaleHeight(27)));
        }];
        
        UIButton *btn_sure = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_sure setBackgroundColor:[UIColor colorWithHexString:@"F5F5F5"]];
        btn_sure.layer.cornerRadius = HScaleHeight(2.5);
        [btn_sure setImage:[UIImage imageNamed:@"btn_sure"] forState:UIControlStateNormal];
        [btn_sure addTarget:self action:@selector(payNumberLabelSure) forControlEvents:UIControlEventTouchUpInside];
        [self.backWhierView addSubview:btn_sure];
        
        [btn_sure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.payNumberLabel.mas_left).offset(-HScaleWidth(1.5));
            make.centerY.mas_equalTo(payNumber.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(27), HScaleHeight(27)));
        }];
        
        
        UIButton *determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [determineBtn setBackgroundColor:[UIColor colorWithHexString:@"DD1A21"]];
        [determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        determineBtn.titleLabel.font = HScaleFont(15);
        determineBtn.layer.cornerRadius = HScaleHeight(18.5);
        [determineBtn addTarget:self action:@selector(okThisOder) forControlEvents:UIControlEventTouchUpInside];

        [self.backWhierView addSubview:determineBtn];
        
        [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(15));
            make.right.mas_equalTo(-HScaleWidth(15));
            make.bottom.mas_equalTo(-kBottomSafeHeight - HScaleHeight(14));
            make.height.mas_equalTo(HScaleHeight(39));
        }];
    }
    return self;
}
- (void)payNumberLabelSure
{
    NSInteger number = [self.payNumberLabel.text intValue];
    if (number != 1) {
        number--;
        self.payNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
    }
}

- (void)payNumberLabelAdd
{
    NSInteger number = [self.payNumberLabel.text intValue];
    number++;
    self.payNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
}
- (void)okThisOder
{
    [self removeFromSuperview];
}
- (void)getSpecModel:(NSArray *)arry
{
    for (NSInteger index = 0; index < arry.count; index ++) {
        NSMutableArray *specArry = [NSMutableArray arrayWithCapacity:0];
        NSDictionary *dic = arry[index];
        NSArray *childArry = dic[@"child"];
        for (NSInteger index_j = 0; index_j < childArry.count; index_j ++) {
            NSDictionary *childDic = childArry[index_j];
            DFChildModel *model = [[DFChildModel alloc]init];//WithDictionary:childDic error:nil];
            model.spec_value_id = childDic[@"spec_value_id"];
            model.spec_value = childDic[@"spec_value"];

            if (index_j == 0) {
                model.isSelect = YES;
                [self.array_selectedModel addObject:model];
            }
            else
            {
                model.isSelect = NO;

            }
            [specArry addObject:model];
            
        }
        
        [self.dataArry addObject:specArry];
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArry.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    NSDictionary *dic = self.dataArry[section];
//    NSArray *numberArry = dic[@"child"];
    
//    LQStandardModel*model = self.array_dataSource[section];
    NSMutableArray *secondArry = self.dataArry[section];
    return secondArry.count;
}
-(__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DFStandardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFStandardCollectionViewCell" forIndexPath:indexPath];

    
    NSMutableArray *secondArry = self.dataArry[indexPath.section];
    
    DFChildModel *model = secondArry[indexPath.row];
    cell.lab_standard.text = model.spec_value;
    if (model.isSelect) {
        cell.lab_standard.backgroundColor = [UIColor colorWithHexString:@"FFDEDF"];
        cell.lab_standard.textColor = [UIColor colorWithHexString:@"DD1A21"];
    }
    else
    {
        cell.lab_standard.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
        cell.lab_standard.textColor = [UIColor colorWithHexString:@"333333"];
    }
    cell.model = model;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableArray *secondArry = self.dataArry[indexPath.section];
    
    DFChildModel *model = secondArry[indexPath.row];
    
    CGFloat width = [model.spec_value widthForFont:HScaleFont(12)] + HScaleWidth(24);

    
    return CGSizeMake(width, HScaleHeight(30));
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        DFStandardCollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DFStandardCollectionReusableView" forIndexPath:indexPath];
        
        NSDictionary *dic = self.detailModel.spec[indexPath.section];
        headView.lab_standard.text = dic[@"spec_name"];

        return headView;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenW, HScaleWidth(34));
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (NSInteger index = 0; index < self.dataArry.count; index ++) {
        
        
        
        
        NSMutableArray *arry = self.dataArry[index];
        
        if (index == indexPath.section) {
            [arry enumerateObjectsUsingBlock:^(DFChildModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == indexPath.item) {
                    obj.isSelect = !obj.isSelect;
                    if (obj.isSelect) {
                        [self.array_selectedModel addObject:obj];
                    }else{
                        [self.array_selectedModel removeObject:obj];
                    }
                }else{
                    obj.isSelect = NO;
                    [self.array_selectedModel removeObject:obj];
                }
            }];
        }

        
    }
    
    [UIView performWithoutAnimation:^{
        //刷新界面
        [self.collectionView reloadData];
    }];
    
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.minimumLineSpacing = 10*WidthRatio;
        layout.minimumInteritemSpacing = HScaleWidth(10);
        layout.sectionInset = UIEdgeInsetsMake(0, HScaleWidth(15), HScaleHeight(10), HScaleWidth(15));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DFStandardCollectionViewCell class] forCellWithReuseIdentifier:@"DFStandardCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DFStandardCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DFStandardCollectionReusableView"];
    }
    return _collectionView;
}
- (NSMutableArray *)dataArry
{
    if (!_dataArry) {
        _dataArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArry;
}

- (NSMutableArray *)array_selectedModel
{
    if (!_array_selectedModel) {
        _array_selectedModel = [NSMutableArray arrayWithCapacity:0];
    }
    return _array_selectedModel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
