//
//  DFGoodsTableViewCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/10.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGoodsTableViewCell.h"
#import "DFStoreGoodsView.h"
#import "DFStoreGoodModel.h"

@interface DFGoodsTableViewCell ()

@property (nonatomic , strong) DFStoreGoodsView *firstGood;
@property (nonatomic , strong) DFStoreGoodsView *secondGood;

@end

@implementation DFGoodsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.firstGood mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleWidth(5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(172.5), HScaleHeight(123.5)));
        }];
        
        [self.secondGood mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.firstGood.mas_right).offset(HScaleWidth(10));
            make.top.mas_equalTo(self.firstGood.mas_top);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(172.5), HScaleHeight(123.5)));
        }];
    }
    return self;
}

- (void)setIndexPath:(NSInteger)indexPath
{
    _indexPath = indexPath;
    DFStoreGoodModel *firstmodel = self.goodArry[indexPath * 2];
    self.firstGood.model = firstmodel;
    
    
    
    if ((indexPath + 1) * 2  > self.goodArry.count) {
        self.secondGood.hidden = YES;
        
    }
    else
    {
        self.secondGood.hidden = NO;
        DFStoreGoodModel *secondmodel = self.goodArry[indexPath * 2 + 1];
        
        self.secondGood.model = secondmodel;

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

- (DFStoreGoodsView *)firstGood
{
    if (!_firstGood) {
        _firstGood = [[DFStoreGoodsView alloc]init];
        [self.contentView addSubview:_firstGood];
    }
    return _firstGood;
}

- (DFStoreGoodsView *)secondGood
{
    if (!_secondGood) {
        _secondGood = [[DFStoreGoodsView alloc]init];
        [self.contentView addSubview:_secondGood];
    }
    return _secondGood;
}

@end
