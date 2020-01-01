//
//  DFXiaoGuoStyleCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFXiaoGuoStyleCell.h"

@interface DFXiaoGuoStyleCell ()

@property (nonatomic , strong) UILabel *styleLabel;

@end

@implementation DFXiaoGuoStyleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(0);
        }];
    }
    return self;
}
- (void)setTiteleTextk:(NSString *)titeleTextk
{
    _titeleTextk = titeleTextk;
    self.styleLabel.text = titeleTextk;
}
- (void)setIsSelect:(BOOL)isSelect
{
    if (isSelect) {
        self.styleLabel.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
        self.styleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    else
    {
        self.styleLabel.backgroundColor = [UIColor colorWithHexString:@"F1F3F6"];
        self.styleLabel.textColor = [UIColor blackColor];


    }
}

- (UILabel *)styleLabel
{
    if (!_styleLabel) {
        _styleLabel = [[UILabel alloc]init];
        _styleLabel.textColor = [UIColor blackColor];
        _styleLabel.backgroundColor = [UIColor colorWithHexString:@"F1F3F6"];
        _styleLabel.layer.cornerRadius = HScaleHeight(2);
        _styleLabel.adjustsFontSizeToFitWidth = YES;
        _styleLabel.layer.masksToBounds = YES;
        _styleLabel.font = HScaleFont(12);
        _styleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_styleLabel];
    }
    return _styleLabel;
}
@end
