//
//  DFHomeWorkListCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/5.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFHomeWorkListCell.h"

@interface DFHomeWorkListCell ()

@property (nonatomic , strong) UIImageView *iconview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) UILabel *subtitle;

@end

@implementation DFHomeWorkListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self.iconview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.right.mas_equalTo(-HScaleWidth(10));
            make.top.mas_equalTo(HScaleWidth(10));
            make.height.mas_equalTo(HScaleHeight(150));
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconview.mas_left);
            make.right.mas_equalTo(self.iconview.mas_right);
            make.top.mas_equalTo(self.iconview.mas_bottom).offset(HScaleHeight(11));
        }];
        
        [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titlelabel.mas_left);
            make.bottom.mas_equalTo(-HScaleHeight(10));
        }];
        
    }
    return self;
}
- (void)setModel:(DFDesignerWorkModel *)model
{
    _model = model;
    
    [self.iconview sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.titlelabel.text = model.title;
    self.subtitle.text = [NSString stringWithFormat:@"%@ | 面积:%@",model.shape[@"name"],model.mianji];
}
- (UIImageView *)iconview
{
    if (!_iconview) {
        _iconview = [[UIImageView alloc]init];
        _iconview.layer.cornerRadius = HScaleWidth(5);
        _iconview.layer.masksToBounds = YES;
        _iconview.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_iconview];
    }
    return _iconview;
}

- (UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.font = HScaleFont(14);
        _titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:_titlelabel];;
    }
    return _titlelabel;
}
- (UILabel *)subtitle
{
    if (!_subtitle) {
        _subtitle = [[UILabel alloc]init];
        _subtitle.font = HScaleFont(11);
        _subtitle.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_subtitle];;
    }
    return _subtitle;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
