//
//  DFGoodsDetailNavView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/13.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGoodsDetailNavView.h"

@interface DFGoodsDetailNavView ()

@property (nonatomic , strong) UIButton *backBtn;

@property (nonatomic , strong) UIButton *sharebtn;

@property (nonatomic , strong) UIButton *mall;

@property (nonatomic , strong) UIView *titleMoreView;

@property (nonatomic , strong) UIView *lineView;
@end

@implementation DFGoodsDetailNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
        self.backBtn.showsTouchWhenHighlighted = NO;
        [self.backBtn setImage:[UIImage imageNamed:@"goods_back"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateSelected];
        [self.backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backBtn];
        
        
        
        
        
        self.sharebtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW - 34.5, kStatusBarHeight, 25.5, 44)];
        self.sharebtn.showsTouchWhenHighlighted = NO;
        [self.sharebtn setImage:[UIImage imageNamed:@"goods_share_un"] forState:UIControlStateNormal];
        [self.sharebtn setImage:[UIImage imageNamed:@"goods_share"] forState:UIControlStateSelected];
//        [sharebtn addTarget:self action:@selector(clickShareAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sharebtn];
        
        
                
        self.mall = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.sharebtn.frame) - 5 - 25.5, kStatusBarHeight, 25.5, 44)];
        self.mall.showsTouchWhenHighlighted = NO;
        [self.mall setImage:[UIImage imageNamed:@"goods_mall_un"] forState:UIControlStateNormal];
        [self.mall setImage:[UIImage imageNamed:@"goods_mall"] forState:UIControlStateSelected];
//        [sharebtn addTarget:self action:@selector(clickShareAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.mall];
        
        
        CGFloat with = CGRectGetMidX(self.mall.frame) - CGRectGetMaxX(self.backBtn.frame);
        
        self.titleMoreView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.backBtn.frame), kStatusBarHeight, with, 44)];
        [self addSubview:self.titleMoreView];
        
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"DB1E2A"];
        [self.titleMoreView addSubview:self.lineView];
        
        NSArray *titleArry = [NSArray arrayWithObjects:@"商品",@"评价",@"详情",@"推荐", nil];
        
        for (NSInteger index = 0; index < titleArry.count ; index ++) {
            
            UIButton *titlebtn = [UIButton buttonWithType:UIButtonTypeCustom];
            titlebtn.tag = index + 100;
            [titlebtn setTitle:titleArry[index] forState:UIControlStateNormal];
            titlebtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [titlebtn addTarget:self action:@selector(changeContentOfset:) forControlEvents:UIControlEventTouchUpInside];
            [titlebtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            [self.titleMoreView addSubview:titlebtn];
            
            [titlebtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(with / 4 * index);
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(with / 4);
            }];
            
            if (index == 0) {
                [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(28);
                    make.height.mas_equalTo(2.5);
                    make.centerX.mas_equalTo(titlebtn.mas_centerX);
                    make.bottom.mas_equalTo(titlebtn.mas_bottom);
                }];
            }
            
        }
        
        
        
        
    }
    return self;
}
- (void)changeLineviewMesonry:(NSInteger)btnTag
{
    UIButton *btn = [self viewWithTag:btnTag + 100];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(2.5);
        make.centerX.mas_equalTo(btn.mas_centerX);
        make.bottom.mas_equalTo(btn.mas_bottom);
    }];
    
}
- (void)changeContentOfset:(UIButton *)sender
{
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(2.5);
        make.centerX.mas_equalTo(sender.mas_centerX);
        make.bottom.mas_equalTo(sender.mas_bottom);
    }];
    
    
    if (self.selectType) {
        self.selectType(sender.tag);
    }
}

- (void)changeSelectWith:(BOOL)isSelect
{
    if (isSelect) {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        self.backBtn.selected = YES;
        self.sharebtn.selected = YES;
        self.mall.selected = YES;
        self.titleMoreView.hidden = NO;
    }
    else
    {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.0];
        self.backBtn.selected = NO;
        self.sharebtn.selected = NO;
        self.mall.selected = NO;
        self.titleMoreView.hidden = YES;
    }

    
}

- (void)clickCancelAction
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
