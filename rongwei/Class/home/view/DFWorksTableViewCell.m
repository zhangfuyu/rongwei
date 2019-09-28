//
//  DFWorksTableViewCell.m
//  rongwei
//
//  Created by apple on 2019/9/27.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFWorksTableViewCell.h"

@interface DFWorksTableViewCell ()

@property (nonatomic , strong)UIImageView *contentImage;

@property (nonatomic , strong)UILabel *numberLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *adreessLabel;

@property (nonatomic , strong)UIButton *rightNowBtn;

@end

@implementation DFWorksTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(HScaleWidth(10));
            make.right.mas_equalTo(-HScaleWidth(10));
            make.height.mas_equalTo(HScaleHeight(175));
        }];
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(50), HScaleHeight(30)));
        }];
         
         
        [self.rightNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentImage.mas_bottom).offset(HScaleHeight(13));
            make.right.mas_equalTo(self.contentImage.mas_right);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(63), HScaleHeight(20)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentImage.mas_bottom).offset(HScaleHeight(10));
            make.left.mas_equalTo(self.contentImage.mas_left);
            make.height.mas_equalTo(HScaleHeight(15));
            make.right.mas_equalTo(self.rightNowBtn.mas_left).offset(HScaleWidth(20));
        }];
        
        
        [self.adreessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom);
            make.right.mas_equalTo(self.nameLabel.mas_right);
            make.height.mas_equalTo(HScaleHeight(10));
        }];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)contentView
{
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc]init];
        _contentImage.layer.cornerRadius = HScaleHeight(3);
        _contentImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_contentImage];
    }
    return _contentImage;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = HScaleFont(12);
        _numberLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        [self.contentView addSubview:_numberLabel];
    }
    return _numberLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = HScaleFont(15);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}
- (UILabel *)adreessLabel
{
    if (!_adreessLabel) {
        _adreessLabel = [[UILabel alloc]init];
        _adreessLabel.font =HScaleFont(10);
        _adreessLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_adreessLabel];
    }
    return _adreessLabel;
}

- (UIButton *)rightNowBtn
{
    if (!_rightNowBtn) {
        _rightNowBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_rightNowBtn setTitle:@"立刻咨询" forState:UIControlStateNormal];
        _rightNowBtn.titleLabel.font = HScaleFont(10);
        [_rightNowBtn setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        _rightNowBtn.layer.borderWidth = 1;
        _rightNowBtn.layer.borderColor = [UIColor colorWithHexString:@"DD1A21"].CGColor;
        [self.contentView addSubview:_rightNowBtn];
    }
    return _rightNowBtn;
}
@end
