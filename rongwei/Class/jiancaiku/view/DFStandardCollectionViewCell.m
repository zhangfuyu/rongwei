//
//  DFStandardCollectionViewCell.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/15.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStandardCollectionViewCell.h"

@implementation DFStandardCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationUI];
    }
    return self;
}

-(void)configurationUI{
    
    UILabel *lab_standard = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    lab_standard.text = @"规格";
    lab_standard.font = HScaleFont(12);
    lab_standard.textAlignment = NSTextAlignmentCenter;
    lab_standard.layer.masksToBounds = YES;
    lab_standard.layer.cornerRadius = HScaleHeight(3);
    [self addSubview:lab_standard];
    self.lab_standard = lab_standard;
    
}
- (void)setModel:(DFChildModel *)model
{
    _model = model;
    self.lab_standard.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


@end
