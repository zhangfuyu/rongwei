//
//  DFMainCellBtn.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/20.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFMainCellBtn.h"

@interface DFMainCellBtn ()

@property (nonatomic , strong) UIImageView *iconimage;

@property (nonatomic , strong) UILabel *textLabel;

@end

@implementation DFMainCellBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.iconimage = [[UIImageView alloc]init];
        [self addSubview:self.iconimage];
        
        [self.iconimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HScaleHeight(15));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(24), HScaleHeight(24)));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        
        self.textLabel = [[UILabel alloc]init];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.textLabel.textColor = [UIColor colorWithHexString:@"3A405E"];
        [self addSubview:self.textLabel];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.iconimage.mas_bottom).offset(HScaleHeight(14));
            make.height.mas_equalTo(HScaleHeight(13));
        }];
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.textLabel.text = titleStr;
}
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.iconimage.image = [UIImage imageNamed:imageName];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
