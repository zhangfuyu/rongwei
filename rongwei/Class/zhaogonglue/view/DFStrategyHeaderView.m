//
//  DFStrategyHeaderView.m
//  rongwei
//
//  Created by apple on 2019/10/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyHeaderView.h"

@implementation DFStrategyHeaderView

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
        UIImageView *first = [[UIImageView alloc]init];
        first.image = [UIImage imageNamed:@"找设计入口 （合并）"];
        [self addSubview:first];
        
        [first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.top.mas_equalTo(HScaleHeight(10));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(175), HScaleHeight(50)));
        }];
        
        UIImageView *secondimage = [[UIImageView alloc]init];
        secondimage.image = [UIImage imageNamed:@"找施工入口（合并）"];
        [self addSubview:secondimage];
        
        [secondimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(first.mas_right).offset(HScaleWidth(10));
            make.top.mas_equalTo(first.mas_top);
            make.right.mas_equalTo(-HScaleWidth(10));
            make.bottom.mas_equalTo(first.mas_bottom);
        }];
        
        UIImageView *three = [[UIImageView alloc]init];
        three.backgroundColor = [UIColor orangeColor];
        [self addSubview:three];
        
        [three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(first.mas_left);
            make.top.mas_equalTo(first.mas_bottom).offset(HScaleHeight(10));
            make.right.mas_equalTo(first.mas_right);
            make.height.mas_equalTo(HScaleHeight(70));
        }];
        
        UIImageView *four = [[UIImageView alloc]init];
        four.backgroundColor = [UIColor orangeColor];

        [self addSubview:four];
        
        [four mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(secondimage.mas_left);
            make.top.mas_equalTo(secondimage.mas_bottom).offset(HScaleHeight(10));
            make.right.mas_equalTo(secondimage.mas_right);
            make.height.mas_equalTo(HScaleHeight(70));

        }];
    }
    return self;
}

@end
