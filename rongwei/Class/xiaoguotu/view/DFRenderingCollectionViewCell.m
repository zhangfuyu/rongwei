//
//  DFRenderingCollectionViewCell.m
//  rongwei
//
//  Created by apple on 2019/10/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//



#import "DFRenderingCollectionViewCell.h"
@interface DFRenderingCollectionViewCell ()

@property (nonatomic , strong)UIImageView *contentimage;

@property (nonatomic , strong)UILabel *titlelabel;

@property (nonatomic , strong)UILabel *sublabel;

@end


@implementation DFRenderingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(85));
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.contentimage.mas_bottom).offset(HScaleHeight(10));
            make.height.mas_equalTo(HScaleHeight(12));
        }];
        
        [self.sublabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.titlelabel.mas_bottom).offset(HScaleHeight(6));
            make.height.mas_equalTo(HScaleHeight(10));

        }];
    }
    return self;
}

- (UIView *)contentView
{
    if (!_contentimage) {
        _contentimage = [[UIImageView alloc]init];
        _contentimage.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_contentimage];
    }
    return self;
}

- (UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        _titlelabel.text = @"日式 | 一居室 | 100m2 | 三万以下";
        _titlelabel.font = HScaleFont(11);
        [self.contentView addSubview:_titlelabel];
    }
    return _titlelabel;
}
- (UILabel *)sublabel
{
    if (!_sublabel) {
        _sublabel = [[UILabel alloc]init];
        _sublabel.textColor = [UIColor colorWithHexString:@"999999"];
        _sublabel.text = @"清风设计";
        _sublabel.font = HScaleFont(10);
        [self.contentView addSubview:_sublabel];
    }
    return _sublabel;
}

@end
