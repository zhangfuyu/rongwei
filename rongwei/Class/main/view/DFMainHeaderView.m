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
        self.frame = CGRectMake(0, 0, ScreenW, HScaleHeight(207));
        UIImageView *bigbackiamg = [[UIImageView alloc]init];
        bigbackiamg.image = [UIImage imageNamed:@"bigMain"];
        [self addSubview:bigbackiamg];
        
        [bigbackiamg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(HScaleHeight(183));
        }];
        
        
        
        self.headerimage = [[UIImageView alloc]init];
        self.headerimage.layer.cornerRadius = HScaleHeight(60) / 2;
        self.headerimage.layer.masksToBounds = YES;
        self.headerimage.backgroundColor = [UIColor orangeColor];
        [bigbackiamg addSubview:self.headerimage];
        
        [self.headerimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(20));
            make.top.mas_equalTo(HScaleHeight(43));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(60), HScaleHeight(60)));
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
        
    }
    return self;
}

@end
