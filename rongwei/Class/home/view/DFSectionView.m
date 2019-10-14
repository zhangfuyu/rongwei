//
//  DFSectionView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/10/14.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSectionView.h"
@interface DFSectionView()

@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic , strong)UILabel *subtitleLabel;

@end

@implementation DFSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleHeight(10));
            make.height.mas_equalTo(HScaleHeight(19));
        }];
        
        [self addSubview:self.subtitleLabel];
        
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(HScaleHeight(7));
            make.height.mas_equalTo(HScaleHeight(11));
        }];
        
    }
    return self;
}
- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    self.titleLabel.text = titleText;
}
- (void)setSubText:(NSString *)subText
{
    _subText = subText;
    self.subtitleLabel.text = subText;
}
- (void)setIsShowSubTitle:(BOOL)isShowSubTitle
{
    _isShowSubTitle = isShowSubTitle;
    if (!_isShowSubTitle) {
        self.subtitleLabel.hidden = YES;
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = HScaleBoldFont(20);
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _titleLabel;
    
}

- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.font = HScaleFont(11);
        _subtitleLabel.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _subtitleLabel;
}
@end
