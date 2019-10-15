//
//  DFSectionView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/10/14.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSectionView.h"
#import "DFEsignerlListViewController.h"

@interface DFSectionView()

@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic , strong)UILabel *subtitleLabel;

@property (nonatomic , strong)UIButton *moreBtn;

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
        
        [self addSubview:self.moreBtn];
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_top);
            make.bottom.mas_equalTo(self.titleLabel.mas_bottom);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(HScaleWidth(21+5+8+13+13));
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

- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(pushMoreVC) forControlEvents:UIControlEventTouchUpInside];
        _moreBtn.titleLabel.font = HScaleFont(11);
    }
    return _moreBtn;
}
- (void)pushMoreVC
{
    if ([self.titleText isEqualToString:@"推荐设计师"]) {
        [self.viewController.navigationController pushViewController:[DFEsignerlListViewController new] animated:YES];
    }
}
@end
