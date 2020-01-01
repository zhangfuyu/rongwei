//
//  DFStoreDetailGoodsCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStoreDetailGoodsCell.h"

@interface DFStoreDetailGoodsCell ()

@property (nonatomic , strong) UIImageView *goodImageview;
@property (nonatomic , strong) UILabel *goodNameLabel;
@property (nonatomic , strong) UILabel *goodPriceLabel;
@property (nonatomic , strong) UILabel *goodPayNumberLabel;

@end

@implementation DFStoreDetailGoodsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.goodImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(85));
        }];
        
        [self.goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodImageview.mas_left);
            make.right.mas_equalTo(self.goodImageview.mas_right);
            make.top.mas_equalTo(self.goodImageview.mas_bottom).offset(HScaleHeight(9.5));
        }];
        
        [self.goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodImageview.mas_left);
            make.right.mas_equalTo(self.goodImageview.mas_centerX);
            make.top.mas_equalTo(self.goodNameLabel.mas_bottom).offset(HScaleHeight(6));
        }];
        
        [self.goodPayNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodPriceLabel.mas_right).offset(HScaleWidth(13));
            make.right.mas_equalTo(self.goodImageview.mas_right).offset(-HScaleWidth(30));
            make.top.mas_equalTo(self.goodNameLabel.mas_bottom).offset(HScaleHeight(5));
        }];
        
    }
    return self;
}

- (void)setModel:(DFStoreGoodModel *)model
{
    _model = model;
    [self.goodImageview sd_setImageWithURL:[NSURL URLWithString:model.goods_thumb] placeholderImage:nil];
    self.goodNameLabel.text = model.goods_name;
    self.goodPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.low_price];
    self.goodPayNumberLabel.text = [NSString stringWithFormat:@"%d人付款",[model.sales_actual intValue] + [model.sales_initial intValue]];
    
}

- (UIImageView *)goodImageview
{
    if (!_goodImageview) {
        _goodImageview = [[UIImageView alloc]init];
        [self addSubview:_goodImageview];
    }
    return _goodImageview;
}

- (UILabel *)goodNameLabel
{
    if (!_goodNameLabel) {
        _goodNameLabel = [[UILabel alloc]init];
        _goodNameLabel.font = HScaleFont(11);
        _goodNameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self addSubview:_goodNameLabel];
    }
    return _goodNameLabel;
}
- (UILabel *)goodPriceLabel
{
    if (!_goodPriceLabel) {
        _goodPriceLabel = [[UILabel alloc]init];
        _goodPriceLabel.font = HScaleFont(10);
        _goodPriceLabel.textColor = [UIColor colorWithHexString:@"DD1A21"];
        [self addSubview:_goodPriceLabel];
    }
    return _goodPriceLabel;
}

- (UILabel *)goodPayNumberLabel
{
    if (!_goodPayNumberLabel) {
        _goodPayNumberLabel = [[UILabel alloc]init];
        _goodPayNumberLabel.font = HScaleFont(10);
        _goodPayNumberLabel.textColor = [UIColor colorWithHexString:@"999999"];
//        _goodPayNumberLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_goodPayNumberLabel];
    }
    return _goodPayNumberLabel;
}

@end
