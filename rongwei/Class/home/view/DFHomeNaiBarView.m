//
//  DFHomeNaiBarView.m
//  rongwei
//
//  Created by apple on 2019/10/15.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFHomeNaiBarView.h"

@implementation DFHomeNaiBarView

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
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self creatui];
    }
    return self;
}

- (void)creatui

{
     UITextField *searchTextField = [[UITextField alloc] init];
       searchTextField.backgroundColor = [UIColor colorWithHexString:@"F5F6FA"];
       searchTextField.layer.cornerRadius = HScaleHeight(14);
       searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
       searchTextField.font = HScaleFont(12);
       searchTextField.textColor = [UIColor colorWithHexString:@"999999"];
       searchTextField.placeholder = @"找施工、设计师";
       searchTextField.userInteractionEnabled = false;
       searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
       searchTextField.layer.shadowOffset = CGSizeMake(0,2);
       searchTextField.layer.shadowOpacity = 1;
       searchTextField.layer.shadowRadius = 4;

       
       searchTextField.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];

       [self addSubview:searchTextField];
       
       UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HScaleWidth(35), HScaleHeight(28))];
       
       UIImageView *searchIconImageView = [[UIImageView alloc] init];
       searchIconImageView.contentMode = UIViewContentModeCenter;
       searchIconImageView.image = [UIImage imageNamed:@"home_search"];
       searchIconImageView.size = CGSizeMake(HScaleWidth(15), HScaleHeight(15));
       [leftview addSubview:searchIconImageView];
       searchIconImageView.center = leftview.center;

       searchTextField.leftView = leftview;
       searchTextField.leftViewMode = UITextFieldViewModeAlways;
       
       [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(HScaleWidth(10));
           make.top.mas_equalTo(HScaleHeight(9)+ kStatusBarHeight);
           make.height.mas_equalTo(HScaleHeight(28));
           make.width.mas_equalTo(HScaleWidth(140));
           
       }];
    
     NSArray *imageArry = @[@"zhaosheji",@"zhaoshigong",@"suanbaojia",@"xiangzixun",@"yaojianli"];
    
    for (NSInteger index = 0; index < imageArry.count ; index ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

        [btn setImage:[UIImage imageNamed:imageArry[index]] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(searchTextField.mas_right).offset(HScaleWidth(8) + index * HScaleWidth(28) + index *HScaleWidth(6));
            make.top.mas_equalTo(searchTextField.mas_top);
            make.bottom.mas_equalTo(searchTextField.mas_bottom);
            make.width.mas_equalTo(HScaleWidth(28));
            
        }];
    }
    
     UIButton *scroup = [UIButton buttonWithType:UIButtonTypeCustom];
          scroup.titleLabel.font = HScaleFont(9);
          scroup.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
          [scroup setTitle:@"回顶部" forState:UIControlStateNormal];
          [scroup setImage:[UIImage imageNamed:@"upmush"] forState:UIControlStateNormal];
          [scroup setTitleColor:[UIColor colorWithHexString:@"DD1A21"] forState:UIControlStateNormal];
//          [locationButton addTarget:self action:@selector(clickLocationAction) forControlEvents:UIControlEventTouchUpInside];
//          locationButton.transform = CGAffineTransformMakeScale(-1, 1);
//          locationButton.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
//          locationButton.imageView.transform = CGAffineTransformMakeScale(-1, 1);
//          [locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    CGFloat imageWith = scroup.imageView.image.size.width;
       CGFloat imageHeight = scroup.imageView.image.size.height;
   
    
        float labelWidth = scroup.titleLabel.intrinsicContentSize.width;
        float labelHeight = scroup.titleLabel.intrinsicContentSize.height;
    
    scroup.imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-3/2.0, 0, 0, -labelWidth);
           scroup.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-3/2.0, 0);
          [self addSubview:scroup];
    
    [scroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(searchTextField.mas_top);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(self.mas_right).offset(-HScaleWidth(52));
        make.bottom.mas_equalTo(searchTextField.mas_bottom);
    }];
    
    [scroup addTarget:self action:@selector(doit) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)doit
{
    if (self.scroToMusrUp) {
        self.scroToMusrUp();
    }
}
@end
