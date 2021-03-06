//
//  DFMainHeaderView.m
//  rongwei
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFMainHeaderView.h"

@implementation DFMainHeaderView

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
        self.frame = CGRectMake(0, 0, ScreenW, HScaleHeight(207)  + kStatusBarHeight - kTopBarDifHeight);
        UIImageView *bigbackiamg = [[UIImageView alloc]init];
        bigbackiamg.image = [UIImage imageNamed:@"bigMain"];
        bigbackiamg.userInteractionEnabled = YES;
        [self addSubview:bigbackiamg];
        
        [bigbackiamg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(183) + kStatusBarHeight - kTopBarDifHeight);
        }];
        
        
        
        self.headerimage = [[UIImageView alloc]init];
        self.headerimage.layer.cornerRadius = HScaleHeight(60) / 2;
        self.headerimage.layer.masksToBounds = YES;
        self.headerimage.backgroundColor = [UIColor orangeColor];
        [bigbackiamg addSubview:self.headerimage];
        
        [self.headerimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(20));
            make.top.mas_equalTo(HScaleHeight(43) + kStatusBarHeight - kTopBarDifHeight);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(60), HScaleHeight(60)));
        }];
        
        
        self.nameLable = [[UILabel alloc]init];
        self.nameLable.font = [UIFont boldSystemFontOfSize:18];
        self.nameLable.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        self.nameLable.text = @"昵称昵称昵称";
        [bigbackiamg addSubview:self.nameLable];
        
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerimage.mas_right).offset(HScaleWidth(15));
            make.top.mas_equalTo(self.headerimage.mas_top).offset(HScaleHeight(12));
            make.height.mas_equalTo(18);
            make.right.mas_equalTo(bigbackiamg.mas_right).offset(-HScaleWidth(20));
        }];
        
        UILabel *secondlaebl = [[UILabel alloc]init];
        secondlaebl.font = [UIFont systemFontOfSize:12];
        secondlaebl.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        secondlaebl.text = @"进入个人主页";
        [bigbackiamg addSubview:secondlaebl];
        
        [secondlaebl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLable.mas_left);
            make.top.mas_equalTo(self.nameLable.mas_bottom).offset(HScaleHeight(10));
            make.height.mas_equalTo(12);
            make.right.mas_equalTo(bigbackiamg.mas_right).offset(-HScaleWidth(20));
        }];
        
        
        
       
        
        
        
        
        UIView *writermyhome = [[UIView alloc]init];
        writermyhome.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        writermyhome.layer.cornerRadius = 5;
        [self addSubview:writermyhome];
        
        [writermyhome mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(13));
            make.right.mas_equalTo(HScaleWidth(-13));
            make.height.mas_equalTo(HScaleHeight(47));
            make.centerY.mas_equalTo(bigbackiamg.mas_bottom);
        }];
        
        UIImageView *iconimage = [[UIImageView alloc]init];
        iconimage.image = [UIImage imageNamed:@"main_home"];
        [writermyhome addSubview:iconimage];
        
        [iconimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(16));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(21), HScaleWidth(21)));
            make.centerY.mas_equalTo(writermyhome.mas_centerY);
        }];
        
        UILabel *homelabel = [[UILabel alloc]init];
        homelabel.font = [UIFont systemFontOfSize:12];
        homelabel.textColor = [UIColor colorWithHexString:@"333333"];
        homelabel.text = @"完善我的家";
        [writermyhome addSubview:homelabel];
        
        [homelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconimage.mas_right).offset(HScaleWidth(10));
            make.top.mas_equalTo(HScaleHeight(11));
            make.height.mas_equalTo(12);
        }];
        
        UILabel *subtitlelabel = [[UILabel alloc]init];
        subtitlelabel.font = [UIFont systemFontOfSize:9];
        subtitlelabel.textColor = [UIColor colorWithHexString:@"999999"];
        subtitlelabel.text = @"为您推荐靠谱实用的案例攻";
        [writermyhome addSubview:subtitlelabel];
        
        [subtitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconimage.mas_right).offset(HScaleWidth(10));
            make.top.mas_equalTo(homelabel.mas_bottom).offset(HScaleHeight(5));
            make.height.mas_equalTo(9);
        }];
        
        
        
        
        NSArray *titleArry = @[@"19\n收藏",@"19\n关注",@"19\n购物车",@"19\n优惠卷"];
        
        CGFloat widhf = (ScreenW - HScaleWidth(13) * 2 ) / 4;
        
        for (NSInteger index = 0; index < 4; index ++) {
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            titleBtn.titleLabel.numberOfLines = 2;
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleBtn setTitle:titleArry[index] forState:UIControlStateNormal];
            [bigbackiamg addSubview:titleBtn];
            
            [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(HScaleWidth(13) + (index *widhf));
                make.top.mas_equalTo(self.headerimage.mas_bottom).offset(HScaleHeight(12));
                make.bottom.mas_equalTo(writermyhome.mas_top).offset(-HScaleHeight(8));
                make.width.mas_equalTo(widhf);
            }];
            
        }
        
        
        
        
        UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [settingbtn setImage:[UIImage imageNamed:@"seting"] forState:UIControlStateNormal];
        [self addSubview:settingbtn];
        
        [settingbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(6));
            make.top.mas_equalTo(HScaleHeight(12) + kStatusBarHeight - kTopBarDifHeight);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(39), HScaleHeight(39)));
        }];
        
        UIButton *messgae = [UIButton buttonWithType:UIButtonTypeCustom];
        [messgae setImage:[UIImage imageNamed:@"xiaoxi"] forState:UIControlStateNormal];
        [self addSubview:messgae];
        
        [messgae mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(settingbtn.mas_left);
            make.top.mas_equalTo(HScaleHeight(12) + kStatusBarHeight - kTopBarDifHeight);
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(39), HScaleHeight(39)));
        }];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([DFUserModelTool shareInstance].isLogin == NO) {
        [self.viewController.navigationController pushViewController:[DFLoginViewController new] animated:YES];
    }
}
@end
