//
//  DFSecondHeaderView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/11/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFSecondHeaderView.h"

@implementation DFSecondHeaderView

- (instancetype)initWithFrame:(CGRect)frame withtitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.text = title;
        titlelabel.font = HScaleFont(15);
        titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titlelabel];
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];

        
        UIView *leftlineview = [[UIView alloc]init];
        leftlineview.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
        [self addSubview:leftlineview];
        
        [leftlineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(titlelabel.mas_left).offset(-HScaleWidth(20));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(HScaleWidth(63));
            make.height.mas_equalTo(HScaleHeight(.5));
        }];
        
        UIView *rightlineview = [[UIView alloc]init];
        rightlineview.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
        [self addSubview:rightlineview];
        
        [rightlineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titlelabel.mas_right).offset(HScaleWidth(20));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(HScaleWidth(63));
            make.height.mas_equalTo(HScaleHeight(.5));
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
