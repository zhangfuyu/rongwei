//
//  DFHomeStrategyCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/5.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFHomeStrategyCell.h"

@interface DFHomeStrategyCell ()

@property (nonatomic , strong) UIImageView *iconview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) UILabel *subtitle;

@end

@implementation DFHomeStrategyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self.iconview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleWidth(15));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(100), HScaleHeight(75)));
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconview.mas_right).offset(HScaleWidth(12.5));
            make.right.mas_equalTo(-HScaleWidth(25.5));
            make.top.mas_equalTo(HScaleHeight(19));
        }];
        
        [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titlelabel.mas_left);
            make.bottom.mas_equalTo(-HScaleHeight(18));
        }];
        
    }
    return self;
}
- (void)setModel:(DFGongLueModel *)model
{
    _model = model;
    
    [self.iconview sd_setImageWithURL:[NSURL URLWithString:model.bbs_pic] placeholderImage:nil];
    self.titlelabel.text = model.bbs_title;
    self.subtitle.text = [NSString stringWithFormat:@"阅读%@ | 评论%@ | %@",model.bbs_view,model.bbs_com_num,model.bbs_user_name];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        _titlelabel.font = HScaleFont(12);
        _titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        _titlelabel.numberOfLines = 2;
        [self.contentView addSubview:_titlelabel];;
    }
    return _titlelabel;
}
- (UILabel *)subtitle
{
    if (!_subtitle) {
        _subtitle = [[UILabel alloc]init];
        _subtitle.font = HScaleFont(10);
        _subtitle.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_subtitle];;
    }
    return _subtitle;
}

@end
