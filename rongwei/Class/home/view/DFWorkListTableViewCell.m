//
//  DFWorkListTableViewCell.m
//  rongwei
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFWorkListTableViewCell.h"

@interface DFWorkListTableViewCell ()

@property (nonatomic , strong) UIImageView *bigimageview;

@property (nonatomic , strong) UILabel *numbercount;

@property (nonatomic , strong) UILabel *namelabel;

@property (nonatomic , strong) UILabel *moretextlabel;

@property (nonatomic , strong) UIButton *nowconsult;

@end

@implementation DFWorkListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.bigimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HScaleHeight(15));
            make.left.mas_equalTo(HScaleWidth(10));
            make.right.mas_equalTo(-HScaleWidth(10));
            make.height.mas_equalTo(HScaleHeight(175));
        }];
        
        [self.numbercount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(self.bigimageview);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(50), HScaleHeight(30)));
        }];
        
        
        [self.nowconsult mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bigimageview.mas_bottom).offset(HScaleHeight(13));
            make.right.mas_equalTo(self.bigimageview.mas_right);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(62.5), HScaleHeight(20)));
        }];
        
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bigimageview.mas_left);
            make.right.mas_equalTo(self.nowconsult.mas_left);
            make.top.mas_equalTo(self.bigimageview.mas_bottom).offset(HScaleHeight(12));
            make.height.mas_equalTo(HScaleHeight(15));
        }];
        
        [self.moretextlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.namelabel.mas_left);
            make.top.mas_equalTo(self.namelabel.mas_bottom).offset(HScaleHeight(10));
            make.height.mas_equalTo(HScaleHeight(10));
        }];
    }
    return self;
}
- (void)setModel:(DFDesignerWorkModel *)model
{
    _model = model;
    [self.bigimageview sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.numbercount.text = [NSString stringWithFormat:@"%@张",model.img_num];
    self.namelabel.text = model.title;
    
    self.moretextlabel.text = [NSString stringWithFormat:@"%@m²",model.mianji];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)bigimageview
{
    if (!_bigimageview) {
        _bigimageview = [[UIImageView alloc]init];
        _bigimageview.layer.cornerRadius = HScaleWidth(3);
        [self.contentView addSubview:_bigimageview];
    }
    return _bigimageview;
}
- (UILabel *)numbercount
{
    if (!_numbercount) {
        _numbercount = [[UILabel alloc]init];
        _numbercount.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _numbercount.textAlignment = NSTextAlignmentCenter;
        _numbercount.font = HScaleFont(12);
        _numbercount.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
        [self.contentView addSubview:_numbercount];
    }
    return _numbercount;
}
- (UILabel *)namelabel
{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = HScaleFont(15);
        _namelabel.textColor = [UIColor colorWithHexString:@"000033"];
        [self.contentView addSubview:_namelabel];
    }
    return _namelabel;
}

- (UILabel *)moretextlabel
{
    if (!_moretextlabel) {
        _moretextlabel = [[UILabel alloc]init];
        _moretextlabel.textColor = [UIColor colorWithHexString:@"999999"];
        _moretextlabel.font = HScaleFont(10);
        [self.contentView addSubview:_moretextlabel];
    }
    return _moretextlabel;
}
- (UIButton *)nowconsult
{
    if (!_nowconsult) {
        _nowconsult = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nowconsult setTitle:@"立即咨询" forState:UIControlStateNormal];
        [_nowconsult setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
        _nowconsult.titleLabel.font = HScaleFont(10);
        _nowconsult.layer.borderWidth = HScaleHeight(.5);
        _nowconsult.layer.borderColor = [UIColor colorWithHexString:@"DD1A21"].CGColor;
        _nowconsult.layer.cornerRadius = HScaleHeight(1);
        [self.contentView addSubview:_nowconsult];
    }
    return _nowconsult;
}
@end
