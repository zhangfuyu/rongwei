//
//  DFStandardCollectionReusableView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/15.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStandardCollectionReusableView.h"

@implementation DFStandardCollectionReusableView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationUI];
    }
    return self;
}
-(void)configurationUI{
    
    UILabel *lab_standard = [[UILabel alloc]initWithFrame:CGRectMake(HScaleWidth(15), HScaleWidth(10), ScreenW - HScaleWidth(30), HScaleWidth(14))];
    lab_standard.font = HScaleFont(12);
    lab_standard.textAlignment = NSTextAlignmentLeft;
    lab_standard.backgroundColor = [UIColor whiteColor];
    lab_standard.textColor = [UIColor blackColor];
    [self addSubview:lab_standard];
    self.lab_standard = lab_standard;
}

@end
