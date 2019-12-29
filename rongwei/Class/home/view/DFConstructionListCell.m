//
//  DFConstructionListCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFConstructionListCell.h"

@interface DFConstructionListCell ()

@property (nonatomic , strong) UIImageView *environmentImage;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *subLabel;

@end

@implementation DFConstructionListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.environmentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(85));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.environmentImage.mas_bottom).offset(HScaleHeight(9.5));
        }];
        
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.right.mas_equalTo(self.titleLabel.mas_right);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(HScaleHeight(5));
        }];
        
    }
    return self;
}
- (void)setModel:(DFConstructionModel *)model
{
    _model = model;
    [self.environmentImage sd_setImageWithURL:[NSURL URLWithString:model.thumb_img] placeholderImage:nil];
    self.titleLabel.text = [NSString stringWithFormat:@"%@|%@",model.quarter_name,model.shape_name];
    self.subLabel.text = model.stage_name;
}

- (UIImageView *)environmentImage
{
    if (!_environmentImage) {
        _environmentImage = [[UIImageView alloc]init];
        _environmentImage.layer.cornerRadius = HScaleWidth(5);
        _environmentImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_environmentImage];
    }
    return _environmentImage;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = HScaleFont(11);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subLabel
{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc]init];
        _subLabel.font = HScaleFont(10);
        _subLabel.textAlignment = NSTextAlignmentCenter;
        _subLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_subLabel];
    }
    return _subLabel;
}

@end
