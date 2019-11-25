//
//  DFItsCollectionViewCell.m
//  rongwei
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFItsCollectionViewCell.h"
@interface DFItsCollectionViewCell ()

@property (nonatomic , strong) UIImageView *imageview;

@property (nonatomic , strong) UILabel *titlelabel;

@property (nonatomic , strong) UILabel *sublabel;
@end


@implementation DFItsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(85));
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.imageview.mas_bottom).offset(HScaleHeight(9.5));
            
        }];
        [self.sublabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.titlelabel.mas_bottom).offset(HScaleHeight(5));
        }];
    }
    return self;
}

- (void)setModel:(DFConstructionModel *)model
{
    _model = model;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.thumb_img] placeholderImage:nil];
    self.titlelabel.text = [NSString stringWithFormat:@"%@|%@",model.quarter_name,model.shape_name];
    self.sublabel.text = model.stage_name;
}
- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc]init];
        _imageview.layer.cornerRadius = HScaleWidth(5);
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
- (UILabel *)sublabel
{
    if (!_sublabel) {
        _sublabel = [[UILabel alloc]init];
        _sublabel.font = HScaleFont(10);
        _sublabel.textAlignment = NSTextAlignmentCenter;
        _sublabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_sublabel];
    }
    return _sublabel;
}
@end
