//
//  DFStrategyCollectionViewCell.m
//  rongwei
//
//  Created by apple on 2019/11/27.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyCollectionViewCell.h"
@interface DFStrategyCollectionViewCell ()

@property (nonatomic , strong) UIImageView *imageview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) UILabel *namelLabel;

@property (nonatomic , strong) UIImageView *lookImage;

@property (nonatomic , strong) UILabel *lookNumberLabel;

@end

@implementation DFStrategyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(85));
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.imageview.mas_bottom).offset(HScaleHeight(9.5));
        }];
        [self.namelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titlelabel.mas_left);
            make.top.mas_equalTo(self.titlelabel.mas_bottom).offset(HScaleHeight(5));
            make.right.mas_equalTo(self.mas_centerX);
        }];
        
        [self.lookNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.titlelabel.mas_bottom).offset(HScaleHeight(6));
        }];
        
        [self.lookImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titlelabel.mas_bottom).offset(HScaleHeight(5.5));
            make.right.mas_equalTo(self.lookNumberLabel.mas_left).offset(-HScaleWidth(3));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(13.5), HScaleHeight(8.5)));
        }];
    }
    return self;
}

- (void)setModel:(DFGongLueModel *)model
{
    _model = model;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.bbs_pic] placeholderImage:nil];
    self.titlelabel.text = model.bbs_title;
    self.namelLabel.text = model.bbs_user_name;
    self.lookNumberLabel.text = model.bbs_view;
}

- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc]init];
//        _imageview.layer.cornerRadius = HScaleWidth(5);
        _imageview.layer.masksToBounds = YES;
        [self.contentView addSubview:_imageview];
    }
    return _imageview;
}

- (UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.font = HScaleFont(11);
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        _titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:_titlelabel];
    }
    return _titlelabel;
}
- (UILabel *)namelLabel
{
    if (!_namelLabel) {
        _namelLabel = [[UILabel alloc]init];
        _namelLabel.font = HScaleFont(10);
        _namelLabel.textAlignment = NSTextAlignmentCenter;
        _namelLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_namelLabel];
    }
    return _namelLabel;
}

- (UIImageView *)lookImage
{
    if (!_lookImage) {
        _lookImage = [[UIImageView alloc]init];
        _lookImage.image = [UIImage imageNamed:@"look-gonglue"];
        [self.contentView addSubview:_lookImage];
    }
    return _lookImage;
}
- (UILabel *)lookNumberLabel
{
    if (!_lookNumberLabel) {
        _lookNumberLabel = [[UILabel alloc]init];
        _lookNumberLabel.font = HScaleFont(10);
        _lookNumberLabel.textAlignment = NSTextAlignmentCenter;
        _lookNumberLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_lookNumberLabel];
    }
    return _lookNumberLabel;
}
@end
