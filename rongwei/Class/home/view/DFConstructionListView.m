//
//  DFConstructionListView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFConstructionListView.h"

@implementation DFConstructionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
              
        NSArray *arry = [NSArray arrayWithObjects:@"先施工在支付",@"工地全程记录",@"施工过程透明", nil];
        
        CGFloat interval = (ScreenW - HScaleHeight(20) - HScaleWidth(105.5)  *3 ) / 2;
        
        for (NSInteger index = 0; index < arry.count; index ++) {
            UILabel *sublabel = [[UILabel alloc]init];
            sublabel.text = arry[index];
            sublabel.backgroundColor = [UIColor colorWithHexString:@"FCE8E8"];
            sublabel.layer.cornerRadius = HScaleHeight(19.5) / 2;
            sublabel.layer.masksToBounds = YES;
            sublabel.textColor = [UIColor colorWithHexString:@"E69D9F"];
            sublabel.font = HScaleFont(11);
            sublabel.textAlignment = NSTextAlignmentCenter;
            sublabel.frame = CGRectMake(HScaleWidth(10) + index % 3 * interval + index * HScaleWidth(105.5), HScaleHeight(15.5), HScaleWidth(105.5), HScaleHeight(19.5));
            [self addSubview: sublabel];
        }
        
        
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.image = [UIImage imageNamed:@"Construction_pic"];
        [self addSubview:imageview];
        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(10));
            make.right.mas_equalTo(-HScaleWidth(10));
            make.height.mas_equalTo(HScaleHeight(100));
            make.top.mas_equalTo(HScaleHeight(44));
        }];
        
        NSArray *backgroundColor = [NSArray arrayWithObjects:@"F5DDDE",@"DFF6E0",@"DCF3F8",@"EAEFC9",@"EFD5C9", nil];
        NSArray *titleColor = [NSArray arrayWithObjects:@"DD1A21",@"00B408",@"009BBD",@"B0B200",@"C93F00", nil];
        NSArray *titlearry = [NSArray arrayWithObjects:@"水电阶段 ",@"泥工阶段 ",@"木工阶段 ",@"油漆阶段",@"保洁修补", nil];

        for (NSInteger index = 0; index < titlearry.count; index ++) {
            UILabel *sublabel = [[UILabel alloc]init];
            sublabel.text = titlearry[index];
            sublabel.backgroundColor = [UIColor colorWithHexString:backgroundColor[index]];
            sublabel.layer.cornerRadius = HScaleHeight(1.5);
            sublabel.layer.masksToBounds = YES;
            sublabel.textColor = [UIColor colorWithHexString:titleColor[index]];
            sublabel.font = HScaleFont(9);
            sublabel.textAlignment = NSTextAlignmentCenter;
            sublabel.frame = CGRectMake((index + 1) * HScaleWidth(10) + index * HScaleWidth(45), HScaleHeight(155), HScaleWidth(45), HScaleHeight(15));
            [self addSubview: sublabel];
        }
        
        
        UIView *linview = [[UIView alloc]init];
        linview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        [self addSubview:linview];
        
        [linview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(HScaleHeight(0));
            make.height.mas_equalTo(HScaleHeight(5));
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
