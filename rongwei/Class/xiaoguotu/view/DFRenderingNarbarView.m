//
//  DFRenderingNarbarView.m
//  rongwei
//
//  Created by apple on 2019/10/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFRenderingNarbarView.h"
@interface DFRenderingNarbarView ()

@property (nonatomic , strong)UIView *lineview;

@end

@implementation DFRenderingNarbarView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *renderingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [renderingBtn setTitle:@"效果图" forState:UIControlStateNormal];
        renderingBtn.titleLabel.font = HScaleFont(15);
        [renderingBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [renderingBtn addTarget:self action:@selector(chousetypeclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:renderingBtn];
        
        [renderingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HScaleWidth(62));
            make.top.mas_equalTo(kStatusBarHeight);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(HScaleWidth(80));
        }];
        
        UIButton *localFigureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [localFigureBtn setTitle:@"局部图" forState:UIControlStateNormal];
        localFigureBtn.titleLabel.font = HScaleFont(15);
        [localFigureBtn addTarget:self action:@selector(chousetypeclick:) forControlEvents:UIControlEventTouchUpInside];
        [localFigureBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [self addSubview:localFigureBtn];
        
        [localFigureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(renderingBtn.mas_right);
            make.top.mas_equalTo(renderingBtn.mas_top);
            make.bottom.mas_equalTo(renderingBtn.mas_bottom);
            make.width.mas_equalTo(HScaleWidth(80));
        }];
        
        UIButton *decorateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [decorateBtn setTitle:@"装修案例" forState:UIControlStateNormal];
        decorateBtn.titleLabel.font = HScaleFont(15);
        decorateBtn.tag = 10086;
        [decorateBtn addTarget:self action:@selector(chousetypeclick:) forControlEvents:UIControlEventTouchUpInside];
        [decorateBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [self addSubview:decorateBtn];
       
        [decorateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(localFigureBtn.mas_right);
            make.top.mas_equalTo(localFigureBtn.mas_top);
            make.bottom.mas_equalTo(localFigureBtn.mas_bottom);
            make.width.mas_equalTo(HScaleWidth(94));
        }];
        
        UIButton *noticeMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [noticeMessageButton setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
        [self addSubview:noticeMessageButton];
      
        [noticeMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(kNavBarHeight);
            make.left.mas_equalTo(decorateBtn.mas_right);
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
        if ([clickbtn.titleLabel.text isEqualToString:@"效果图"]) {
            self.chooseConditionsBlock(DFconditions_Rendering);
        }
        else if ([clickbtn.titleLabel.text isEqualToString:@"局部图"])
        {
            self.chooseConditionsBlock(DFconditions_LocalFigure);

        }
        else
        {
            self.chooseConditionsBlock(DFconditions_DecorateACase);

        }
    }
}

- (void)setSTraTegyStyle:(DFconditions)sTraTegyStyle
{
    if (sTraTegyStyle == DFconditions_DecorateACase) {//装修案例
        UIButton *tuijiananli = [self viewWithTag:10086];
        
        [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.centerX.mas_equalTo(tuijiananli.mas_centerX);
             make.bottom.mas_equalTo(tuijiananli.mas_bottom);
             make.height.mas_equalTo(HScaleHeight(2));
             make.width.mas_equalTo([self sizeWithText:tuijiananli.titleLabel.text font:HScaleFont(15) maxSize:CGSizeMake(MAXFLOAT, HScaleHeight(15))].width);
        }];
    }
//    else
//    {
//        UIButton *gonglue = [self viewWithTag:10087];
//
//        [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
//             make.centerX.mas_equalTo(gonglue.mas_centerX);
//             make.bottom.mas_equalTo(gonglue.mas_bottom);
//             make.height.mas_equalTo(HScaleHeight(2));
//             make.width.mas_equalTo([self sizeWithText:gonglue.titleLabel.text font:HScaleFont(15) maxSize:CGSizeMake(MAXFLOAT, HScaleHeight(15))].width);
//        }];
//    }
    
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
