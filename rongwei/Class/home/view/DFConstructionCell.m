//
//  DFConstructionCell.m
//  rongwei
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFConstructionCell.h"

@interface DFConstructionCell ()

@property (nonatomic , strong) UIImageView *imageview;

@property (nonatomic , strong) UILabel *titlelabel;

@end

@implementation DFConstructionCell



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(100));
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(self.imageview.mas_bottom);
            
        }];
    }
    return self;
}
- (void)setModel:(DFConstructionModel *)model
{
    _model = model;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.thumb_img] placeholderImage:nil];
    self.titlelabel.text = [NSString stringWithFormat:@"%@|%@",model.quarter_name,model.shape_name];
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

@end
