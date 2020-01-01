//
//  DFConstructionSiteCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFConstructionSiteCell.h"
#import "DFConstructionSiteDetailCell.h"

@interface DFConstructionSiteCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionview;

@property (nonatomic , strong) UIView *gardenView;

@property (nonatomic , strong) UIView *linview;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *contentLabel;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) NSMutableArray *image_Arry;


@end

@implementation DFConstructionSiteCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.gardenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(22.5));
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(15), HScaleHeight(15)));
        }];
        
        [self.linview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.gardenView.mas_centerX);
            make.width.mas_equalTo(HScaleWidth(.5));
            make.top.mas_equalTo(self.gardenView.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gardenView.mas_right).offset(HScaleWidth(11.5));
            make.centerY.mas_equalTo(self.gardenView.mas_centerY);
        }];
    
        
        [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gardenView.mas_right).offset(HScaleWidth(11.5));
            make.top.mas_equalTo(self.gardenView.mas_bottom).offset(HScaleHeight(5));
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(88.5));
        }];
        
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gardenView.mas_right).offset(HScaleWidth(11.5));
            make.top.mas_equalTo(self.collectionview.mas_bottom).offset(HScaleHeight(8.5));
            make.right.mas_equalTo(-HScaleWidth(20.5));
        }];
        
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gardenView.mas_right).offset(HScaleWidth(11.5));
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(HScaleHeight(10));
        }];
    }
    return self;
}

- (void)setModel:(DFStageInfosSiteModel *)model
{
    _model = model;
    
    
    self.titleLabel.text = model.stage_name;
    self.timeLabel.text = model.updated_at;
    self.image_Arry = [NSMutableArray arrayWithArray:model.pic_json];
    self.contentLabel.text = model.note;
    if (self.image_Arry.count == 0) {
        [self.collectionview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gardenView.mas_right).offset(HScaleWidth(11.5));
            make.top.mas_equalTo(self.gardenView.mas_bottom).offset(HScaleHeight(5));
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(.1);
        }];
    }
    else
    {
        [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gardenView.mas_right).offset(HScaleWidth(11.5));
            make.top.mas_equalTo(self.gardenView.mas_bottom).offset(HScaleHeight(5));
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(88.5));
        }];
    }
    
    [self.collectionview reloadData];
}
- (void)setStage_name:(NSString *)stage_name
{
    _stage_name = stage_name;
    if ([stage_name isEqualToString:self.titleLabel.text]) {
        self.gardenView .backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"DD1A21"];
    }
    else
    {
        self.gardenView .backgroundColor = [UIColor colorWithHexString:@"DDDDDD"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];

    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - 代理方法 Delegate Methods
// 设置分区

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.image_Arry.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DFConstructionSiteDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DFConstructionSiteDetailCell class]) forIndexPath:indexPath];
//    [cell refreshCellWithTitle:self.nameArray[indexPath.row]];
    cell.urlStr = self.image_Arry[indexPath.row];
    return cell;
}

// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 35.0f;
//    CGFloat width = [self gainStringWidthWithString:self.nameArray[indexPath.row] font:15.0f height:height];
    return CGSizeMake(HScaleWidth(118), HScaleHeight(88.5));
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

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"DD1A21"];
        _titleLabel.font = HScaleFont(12);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = HScaleFont(11);
        _timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = HScaleFont(11);
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        
        // 1.创建流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionview registerClass:[DFConstructionSiteDetailCell class] forCellWithReuseIdentifier:@"DFConstructionSiteDetailCell"];
            /// 设置此属性为yes 不满一屏幕 也能滚动
        _collectionview.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _collectionview.alwaysBounceHorizontal = YES;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
   
        [self.contentView addSubview:_collectionview];
    }
    return _collectionview;
 
}
- (UIView *)gardenView
{
    if (!_gardenView) {
        _gardenView = [[UIView alloc]init];
        _gardenView.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
        _gardenView.layer.cornerRadius = HScaleWidth(7.5);
        [self.contentView addSubview:_gardenView];
    }
    return _gardenView;
}
- (UIView *)linview
{
    if (!_linview) {
        _linview = [[UIView alloc]init];
        _linview.backgroundColor = [UIColor colorWithHexString:@"E7E7E7"];
        [self.contentView addSubview:_linview];
    }
    return _linview;
}
@end
