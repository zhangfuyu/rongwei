//
//  DFConstructionSiteDetailCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFConstructionSiteDetailCell.h"

@interface DFConstructionSiteDetailCell ()

@property (nonatomic , strong) UIImageView *contrntImage;

@end

@implementation DFConstructionSiteDetailCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contrntImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
    [self.contrntImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
}

- (UIImageView *)contrntImage
{
    if (!_contrntImage) {
        _contrntImage = [[UIImageView alloc]init];
//        _contrntImage.layer.cornerRadius = HScaleWidth(5);
//        _contrntImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_contrntImage];
    }
    return _contrntImage;
}
@end
