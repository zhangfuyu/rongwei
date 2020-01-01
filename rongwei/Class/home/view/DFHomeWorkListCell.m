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

@property (nonatomic , strong) UIImageView *peopleImaheview;

@property (nonatomic , strong) UILabel *namelabel;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) UILabel *subtitle;

@property (nonatomic , strong) UILabel *numberLabel;

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
        
        [self.peopleImaheview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconview.mas_left).offset(HScaleWidth(10));
            make.bottom.mas_equalTo(self.iconview.mas_bottom).offset(-HScaleHeight(5));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(25), HScaleHeight(25)));
        }];
        
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.peopleImaheview.mas_right).offset(HScaleWidth(8.5));
            make.right.mas_equalTo(self.iconview.mas_right).offset(-HScaleWidth(10));
            make.centerY.mas_equalTo(self.peopleImaheview.mas_centerY);
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
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(10));
            make.top.mas_equalTo(self.subtitle.mas_top);
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
    self.numberLabel.text = [NSString stringWithFormat:@"收藏 %@  |  阅读%@ ",model.coll_nums,model.hits];
    [self.peopleImaheview sd_setImageWithURL:[NSURL URLWithString:model.designer_image] placeholderImage:nil];
    self.namelabel.text = model.designer_name;
}
- (void)setIsRecommended:(BOOL)isRecommended
{
    _isRecommended = isRecommended;
    if (!isRecommended) {
        
        
        [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.iconview.mas_right).offset(-HScaleWidth(19.5));
            make.bottom.mas_equalTo(self.iconview.mas_bottom).offset(-HScaleHeight(10.5));
            
        }];
        self.numberLabel.text = [NSString stringWithFormat:@"阅读%@",self.model.hits];
        self.numberLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
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

- (UIImageView *)peopleImaheview
{
    if (!_peopleImaheview) {
        _peopleImaheview = [[UIImageView alloc]init];
        [self.contentView addSubview:_peopleImaheview];
    }
    return _peopleImaheview;
}

- (UILabel *)namelabel
{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = HScaleFont(12);
        _namelabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self.contentView addSubview:_namelabel];;
    }
    return _namelabel;
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
- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = HScaleFont(11);
        _numberLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _numberLabel.hidden = NO;
        _numberLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_numberLabel];;
    }
    return _numberLabel;
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
