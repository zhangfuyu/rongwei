//
//  DFMainSeconView.m
//  rongwei
//
//  Created by zhangfuyu on 2020/1/9.
//  Copyright © 2020 zhangfuyu. All rights reserved.
//

#import "DFMainSeconView.h"

@interface DFMainSeconView ()

@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation DFMainSeconView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = HScaleFont(12);
        self.titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
        
        [self addSubview:self.titleLabel];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(HScaleWidth(20));
        }];
        
        
    }
    return self;
}


- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    self.titleLabel.text = titleText;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
