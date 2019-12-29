//
//  DFStrategyView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStrategyView.h"
@interface DFStrategyView ()

@property (nonatomic , strong)UIView *lineview;

@end

@implementation DFStrategyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *renderingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [renderingBtn setTitle:@"攻略" forState:UIControlStateNormal];
        renderingBtn.titleLabel.font = HScaleFont(15);
        [renderingBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [renderingBtn addTarget:self action:@selector(chousetypeclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:renderingBtn];
        
        [renderingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kTopBarSafeHeight);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(HScaleWidth(80));
            make.right.mas_equalTo(self.mas_centerX);
        }];
        
        UIButton *localFigureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [localFigureBtn setTitle:@"咨询" forState:UIControlStateNormal];
        localFigureBtn.titleLabel.font = HScaleFont(15);
        [localFigureBtn addTarget:self action:@selector(chousetypeclick:) forControlEvents:UIControlEventTouchUpInside];
        [localFigureBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [self addSubview:localFigureBtn];
        
        [localFigureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kTopBarSafeHeight);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(HScaleWidth(80));
            make.left.mas_equalTo(self.mas_centerX);
        }];
        
        UIButton *noticeMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [noticeMessageButton setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
        [self addSubview:noticeMessageButton];
      
        [noticeMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            
        }];
      
        [noticeMessageButton addTarget:self action:@selector(clickNoticeAction) forControlEvents:UIControlEventTouchUpInside];
           
        
        
        UIView *downlineview = [[UIView alloc]init];
        downlineview.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
        [self addSubview:downlineview];
        
        [downlineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        
        self.lineview = [[UIView alloc]init];
        self.lineview.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
        [self addSubview:self.lineview];
        
        [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(renderingBtn.mas_centerX);
            make.bottom.mas_equalTo(renderingBtn.mas_bottom);
            make.height.mas_equalTo(HScaleHeight(2));
            make.width.mas_equalTo([self sizeWithText:@"效果图" font:HScaleFont(15) maxSize:CGSizeMake(MAXFLOAT, HScaleHeight(15))].width);
        }];
    }
    
    
    return self;
}
- (void)chousetypeclick:(UIButton *)clickbtn
{
    [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(clickbtn.mas_centerX);
         make.bottom.mas_equalTo(clickbtn.mas_bottom);
         make.height.mas_equalTo(HScaleHeight(2));
         make.width.mas_equalTo([self sizeWithText:clickbtn.titleLabel.text font:HScaleFont(15) maxSize:CGSizeMake(MAXFLOAT, HScaleHeight(15))].width);
    }];
    
    
    if (self.chooseConditionsBlock) {
        if ([clickbtn.titleLabel.text isEqualToString:@"攻略"]) {
            self.chooseConditionsBlock(DFStrategy_Strategy);
        }
        else if ([clickbtn.titleLabel.text isEqualToString:@"咨询"])
        {
            self.chooseConditionsBlock(DFStrategy_information);

        }

    }
}

- (void)clickNoticeAction
{
    
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
