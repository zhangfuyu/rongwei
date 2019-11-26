//
//  DFStrategyTableViewCell.m
//  rongwei
//
//  Created by apple on 2019/10/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyTableViewCell.h"

@interface DFStrategyTableViewCell ()

@property (nonatomic , strong) UIImageView *iconview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) UILabel *subtitle;

@end

@implementation DFStrategyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.iconview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HScaleHeight(15));
            make.bottom.mas_equalTo(-HScaleHeight(15));
            make.right.mas_equalTo(-HScaleWidth(10));
            make.width.mas_equalTo(HScaleWidth(120));
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(12));
            make.top.mas_equalTo(HScaleHeight(15));;
            make.right.mas_equalTo(self.iconview.mas_left).offset(-HScaleWidth(26));
        }];
        
        [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titlelabel.mas_left);
            make.right.mas_equalTo(self.titlelabel.mas_right);
            make.bottom.mas_equalTo(-HScaleHeight(15));
            make.height.mas_equalTo(HScaleHeight(11));
            
        }];
        
        self.titlelabel.text = @"卧室风水怎么整能旺财 卧室中的六大风 水禁忌";
        self.subtitle.text = @"阅读3.4k | 评论10 | 作者";
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
