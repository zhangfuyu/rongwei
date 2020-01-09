//
//  DFSectionView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/10/14.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSectionView.h"
#import "DFEsignerlListViewController.h"
#import "DFMoreStoreViewController.h"
#import "DFContructionListViewController.h"
#import "DFHomeNavModel.h"
#import "DFStrategyDetailViewController.h"
#import "DFXiaoGuoTuViewController.h"
#import "DFNavigationController.h"

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
        
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
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

- (void)setHotArry:(NSMutableArray *)hotArry
{
    _hotArry = hotArry;
    
    for (NSInteger index = 0; index < hotArry.count; index++) {
        
        DFHomeNavModel *model = hotArry[index];

        UIImageView *imaview = [[UIImageView alloc]init];
        imaview.backgroundColor = [UIColor orangeColor];
        imaview.layer.cornerRadius = HScaleHeight(5);
        imaview.layer.masksToBounds = YES;
        [imaview sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:nil];
        [self addSubview:imaview];
        
        imaview.frame = CGRectMake((index % 2 + 1) * HScaleWidth(10) + index % 2 * HScaleWidth(172.5), (index / 2 + 1 ) * HScaleHeight(10) + index / 2 * HScaleHeight(100) + HScaleHeight(39), HScaleWidth(172.5), HScaleHeight(100));
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickBtn addTarget:self action:@selector(pushGonglue:) forControlEvents:UIControlEventTouchUpInside];
        clickBtn.tag = 10086 +index;
        [self addSubview:clickBtn];
        
        clickBtn.frame = CGRectMake((index % 2 + 1) * HScaleWidth(10) + index % 2 * HScaleWidth(172.5), (index / 2 + 1 ) * HScaleHeight(10) + index / 2 * HScaleHeight(100) + HScaleHeight(39), HScaleWidth(172.5), HScaleHeight(100));
    }
    
}
- (void)pushGonglue:(UIButton *)sender
{
    
    DFHomeNavModel *model = self.hotArry[sender.tag - 10086];
    [[DFUserModelTool shareInstance] formeController:self.viewController withModel:model];
//    DFStrategyDetailViewController *detail = [[DFStrategyDetailViewController alloc]init];
//    detail.modelid = model.modelid;
//    [self.viewController.navigationController pushViewController:detail animated:YES];
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
    else if ([self.titleText isEqualToString:@"合作伙伴"])
    {
        [self.viewController.navigationController pushViewController:[DFMoreStoreViewController new] animated:YES];
    }
    else if ([self.titleText isEqualToString:@"施工工地"])
    {
        
        [self.viewController.navigationController pushViewController:[DFContructionListViewController new] animated:YES];

    }
    else if ([self.titleText isEqualToString:@"推荐案例"])
    {
        [self.viewController.tabBarController setSelectedIndex:1];
        
        

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//            [[NSNotificationCenter defaultCenter] postNotificationName:@"TuiJianAnLi" object:nil];//到顶通知父视图改变状态
            
            DFNavigationController *naviController = self.viewController.tabBarController.selectedViewController;
            DFXiaoGuoTuViewController *xiaoguotu = (DFXiaoGuoTuViewController *)naviController.topViewController;;
            [xiaoguotu chaGongLue];

        });
        

    }
    else if ([self.titleText isEqualToString:@"热门攻略"])
    {
        [self.viewController.tabBarController setSelectedIndex:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   NSLog(@"run-----");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chaGongLue" object:nil];//到顶通知父视图改变状态

          
        });
    }

}
@end
