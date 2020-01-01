//
//  DFStoreMoreDetailViewController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/20.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStoreMoreDetailViewController.h"

@interface DFStoreMoreDetailViewController ()

@end

@implementation DFStoreMoreDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    scrollview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
    [self.view addSubview:scrollview];
    
    scrollview.contentSize = CGSizeMake(ScreenW, ScreenH);
    
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HScaleHeight(15)- kBottomSafeHeight - HScaleHeight(40));
    }];
    
    
    UIImageView *backImage = [[UIImageView alloc]init];
    [scrollview addSubview:backImage];
    
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(301) + kStatusBarHeight);
        make.width.mas_equalTo(ScreenW);

    }];
    
    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];

    effectView.alpha = .9;

    [scrollview addSubview:effectView];
    
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
                
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(301) +kStatusBarHeight);
        make.width.mas_equalTo(ScreenW);


    }];
    if (self.model.carousel_image.count > 0) {
        NSString *imageUrl = self.model.carousel_image[0];

        [backImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    }
    
    
    UIView *loginView = [[UIView alloc]init];
    loginView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [scrollview addSubview:loginView];
    
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(10));
        make.top.mas_equalTo(HScaleHeight(50) + kStatusBarHeight);
        make.height.mas_equalTo(HScaleHeight(70));
        make.width.mas_equalTo(ScreenW - HScaleWidth(20));
    }];
    
    UIImageView *logoimage = [[UIImageView alloc]init];
    [logoimage sd_setImageWithURL:[NSURL URLWithString:self.model.logo_image] placeholderImage:nil];
    [loginView addSubview:logoimage];
    
    [logoimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HScaleHeight(10));
        make.left.mas_equalTo(HScaleWidth(10));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(50), HScaleHeight(50)));
    }];
    
    UILabel *storeName = [[UILabel alloc]init];
    storeName.font = HScaleFont(15);
    storeName.textColor = [UIColor colorWithHexString:@"333333"];
    storeName.text = self.model.shop_name;
    [loginView addSubview:storeName];
    
    [storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoimage.mas_right).offset(HScaleWidth(15.5));
        make.top.mas_equalTo(logoimage.mas_top).offset(HScaleHeight(3.5));
        make.right.mas_equalTo(-HScaleWidth(10));
    }];
    
    UILabel *businessLabel = [[UILabel alloc]init];
    businessLabel.font = HScaleFont(12);
    businessLabel.textColor = [UIColor colorWithHexString:@"333333"];
    businessLabel.text = self.model.address;
    [loginView addSubview:businessLabel];
    
    [businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoimage.mas_right).offset(HScaleWidth(15.5));
        make.top.mas_equalTo(storeName.mas_bottom).offset(HScaleHeight(11));
        make.right.mas_equalTo(-HScaleWidth(10));
    }];
    

    UIView *scoreView = [[UIView alloc]init];
    scoreView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [scrollview addSubview:scoreView];

    [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(10));
        make.width.mas_equalTo(ScreenW - HScaleWidth(20));
        make.top.mas_equalTo(loginView.mas_bottom).offset(HScaleHeight(10));
        make.height.mas_equalTo(HScaleHeight(107));
    }];
    
    
    NSArray *scoreArry = [NSArray arrayWithObjects:@"商品描述",@"卖家服务",@"物流服务", nil];
    NSArray *scoreNumberArry = [NSArray arrayWithObjects:self.model.description_score,self.model.service_score,self.model.logistics_score, nil];
    
    for (NSInteger index = 0; index < scoreArry.count; index ++) {
        UILabel *scoreLabel = [[UILabel alloc]init];
        scoreLabel.font = HScaleFont(15);
        scoreLabel.textAlignment = NSTextAlignmentLeft;
        scoreLabel.textColor = [UIColor colorWithHexString:@"333333"];
        scoreLabel.text = scoreArry[index];
//        scoreLabel.attributedText = [self changewithText:scoreArry[index] withScore:scoreNumberArry[index]];
        [scoreView addSubview:scoreLabel];
        
        
        UILabel *numberLabel = [[UILabel alloc]init];
        numberLabel.font = HScaleFont(15);
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.text = scoreArry[index];
        numberLabel.attributedText = [self changewithText:scoreArry[index] withScore:scoreNumberArry[index]];
        [scoreView addSubview:numberLabel];
        

        if (index == 0) {
            [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(HScaleWidth(16.5));
                make.top.mas_equalTo(HScaleWidth(17));
            }];
        }
        else if (index == 1)
        {
            [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(HScaleWidth(16.5));
                make.top.mas_equalTo(HScaleWidth(47));
            }];
        }
        else
        {
            [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(HScaleWidth(16.5));
                make.top.mas_equalTo(HScaleWidth(77));
            }];
        }
        
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HScaleWidth(16.5));
            make.top.mas_equalTo(scoreLabel.mas_top);
            make.bottom.mas_equalTo(scoreLabel.mas_bottom);
        }];
        
        
    }
    
    
    UIView *IntroductionVew = [[UIView alloc]init];
    IntroductionVew.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [scrollview addSubview:IntroductionVew];
    
    
    [IntroductionVew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scoreView.mas_bottom).offset(HScaleHeight(10));
        make.left.mas_equalTo(HScaleWidth(10));
        make.width.mas_equalTo(ScreenW - HScaleWidth(20));
        make.height.mas_equalTo(HScaleHeight(100));
    }];
    
    
    CGFloat heightBrief = HScaleHeight(17);
    
    
    UILabel *businessLabel2 = [[UILabel alloc]init];
    businessLabel2.font = HScaleFont(15);
    businessLabel2.textAlignment = NSTextAlignmentLeft;
    businessLabel2.textColor = [UIColor colorWithHexString:@"333333"];
    businessLabel2.text = @"主营业务";
    [IntroductionVew addSubview:businessLabel2];
    
    [businessLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(16.5));
        
        make.top.mas_equalTo(HScaleHeight(17));
    }];
    
    heightBrief += HScaleHeight(15);
    
    
    UILabel *businessLabelSub = [[UILabel alloc]init];
    businessLabelSub.font = HScaleFont(15);
    businessLabelSub.textAlignment = NSTextAlignmentLeft;
    businessLabelSub.textColor = [UIColor colorWithHexString:@"999999"];
    businessLabelSub.text = self.model.shop_category;
    [IntroductionVew addSubview:businessLabelSub];
    
    [businessLabelSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleHeight(102.5));
        make.right.mas_equalTo(-HScaleWidth(25.5));
        make.top.mas_equalTo(businessLabel2.mas_top);
    }];
    
    CGFloat lableHeight = [self.model.shop_category heightForFont:businessLabelSub.font width:ScreenW - HScaleWidth(20) - HScaleHeight(102.5) - HScaleWidth(25.5)];
    
    
    heightBrief += lableHeight;
    
    heightBrief += HScaleHeight(15.5);
    
    UILabel *IntroductionLbel = [[UILabel alloc]init];
    IntroductionLbel.font = HScaleFont(15);
    IntroductionLbel.textAlignment = NSTextAlignmentLeft;
    IntroductionLbel.textColor = [UIColor colorWithHexString:@"333333"];
    IntroductionLbel.text = @"店铺简介";
    [IntroductionVew addSubview:IntroductionLbel];
    
    [IntroductionLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(16.5));
        if (self.model.shop_category.length > 0) {
            make.top.mas_equalTo(businessLabelSub.mas_bottom).offset(HScaleHeight(15.5));
        }
        else
        {
            make.top.mas_equalTo(businessLabel2.mas_bottom).offset(HScaleHeight(15.5));

        }
        make.width.mas_equalTo([@"店铺简介" widthForFont:HScaleFont(15)] + 10);
    }];
    
    
    UILabel *IntroductionLbelDetail = [[UILabel alloc]init];
    IntroductionLbelDetail.font = HScaleFont(15);
    IntroductionLbelDetail.textAlignment = NSTextAlignmentLeft;
    IntroductionLbelDetail.textColor = [UIColor colorWithHexString:@"999999"];
    IntroductionLbelDetail.text = self.model.brief;
    IntroductionLbelDetail.numberOfLines = 0;
    [IntroductionVew addSubview:IntroductionLbelDetail];
    
    [IntroductionLbelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleHeight(102.5));
        make.right.mas_equalTo(-HScaleWidth(25.5));
        make.top.mas_equalTo(IntroductionLbel.mas_top);

    }];
    
    lableHeight = [self.model.brief heightForFont:businessLabelSub.font width:ScreenW - HScaleWidth(20) - HScaleHeight(102.5) - HScaleWidth(25.5)];
    
    heightBrief += lableHeight;
    
    
    heightBrief += HScaleHeight(15.5);
    
    heightBrief += HScaleHeight(15);
    
    UILabel *storeTime = [[UILabel alloc]init];
    storeTime.font = HScaleFont(15);
    storeTime.textAlignment = NSTextAlignmentLeft;
    storeTime.textColor = [UIColor colorWithHexString:@"333333"];
    storeTime.text = @"开店时间";
    [IntroductionVew addSubview:storeTime];
    
    
    [storeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(16.5));
        if (self.model.brief.length > 0) {
            make.top.mas_equalTo(IntroductionLbelDetail.mas_bottom).offset(HScaleHeight(15.5));
        }
        else
        {
            make.top.mas_equalTo(IntroductionLbel.mas_bottom).offset(HScaleHeight(15.5));

        }
        make.width.mas_equalTo([@"开店时间" widthForFont:HScaleFont(15)] + 10);
    }];
    
    
    UILabel *timerLabel = [[UILabel alloc]init];
    timerLabel.font = HScaleFont(15);
    timerLabel.textAlignment = NSTextAlignmentLeft;
    timerLabel.textColor = [UIColor colorWithHexString:@"999999"];
    timerLabel.text = self.model.created_at;
    timerLabel.numberOfLines = 0;
    [IntroductionVew addSubview:timerLabel];
    
    [timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleHeight(102.5));
        make.right.mas_equalTo(-HScaleWidth(25.5));
        make.top.mas_equalTo(storeTime.mas_top);

    }];
    
    heightBrief += HScaleHeight(15.5);
    
    heightBrief += HScaleHeight(15);
    
    
    UILabel *brandLebel = [[UILabel alloc]init];
    brandLebel.font = HScaleFont(15);
    brandLebel.textAlignment = NSTextAlignmentLeft;
    brandLebel.textColor = [UIColor colorWithHexString:@"333333"];
    brandLebel.text = @"销售品牌";
    [IntroductionVew addSubview:brandLebel];
    
    [brandLebel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(16.5));
        make.top.mas_equalTo(storeTime.mas_bottom).offset(HScaleHeight(15.5));
        make.width.mas_equalTo([@"销售品牌" widthForFont:HScaleFont(15)] + 10);

    }];
    
    
        
    UILabel *brandLebelDetail = [[UILabel alloc]init];
    brandLebelDetail.font = HScaleFont(15);
    brandLebelDetail.textAlignment = NSTextAlignmentLeft;
    brandLebelDetail.textColor = [UIColor colorWithHexString:@"999999"];
    brandLebelDetail.text = self.model.brand;
    brandLebelDetail.numberOfLines = 0;
    [IntroductionVew addSubview:brandLebelDetail];
    
    [brandLebelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleHeight(102.5));
        make.right.mas_equalTo(-HScaleWidth(25.5));
        make.top.mas_equalTo(brandLebel.mas_top);

    }];
    
    lableHeight = [self.model.brand heightForFont:brandLebelDetail.font width:ScreenW - HScaleWidth(20) - HScaleHeight(102.5) - HScaleWidth(25.5)];

    heightBrief += lableHeight;
    
    heightBrief += HScaleHeight(22.5);
    
    [IntroductionVew mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(heightBrief);
        make.bottom.mas_equalTo(0);
    }];
    
    [self creatNavView];

    
    
    UIButton *seeMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seeMoreBtn setBackgroundColor:[UIColor colorWithHexString:@"DD1A21"]];
    [seeMoreBtn setTitle:@"去看看全部商品 >" forState:UIControlStateNormal];
    seeMoreBtn.titleLabel.font = HScaleFont(15);
    [seeMoreBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    [seeMoreBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    seeMoreBtn.layer.cornerRadius = HScaleHeight(20);
    [self.view addSubview:seeMoreBtn];
    
    [seeMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(15));
        make.right.mas_equalTo(-HScaleWidth(15));
        make.height.mas_equalTo(HScaleHeight(40));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-HScaleHeight(15)- kBottomSafeHeight);
    }];
    
    
    

}



- (void)creatNavView
{
    UIView *navView = [[UIView alloc]init];
    navView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    [self.view addSubview:navView];
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"店铺详情";
    titleLabel.font = HScaleFont(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    [navView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarHeight);
    }];
    
    

    
    
    
    
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
}
- (NSMutableAttributedString *)changewithText:(NSString *)text withScore:(NSString *)score
{
    NSInteger scorenumber = score.intValue;
    
    NSString *rellyScore = @"";
    
    NSString *showText = @"";
    
    UIColor *showColor;
    
    if (scorenumber == 1  || scorenumber == 2) {
        rellyScore = [NSString stringWithFormat:@"  %ld分  低",scorenumber];
        showColor = [UIColor colorWithHexString:@"02C90B"];
        
    }
    else if (scorenumber == 3)
    {
        rellyScore = [NSString stringWithFormat:@"  %ld分  中",scorenumber];
        showColor = [UIColor colorWithHexString:@"FFA700"];

    }
    else
    {
        rellyScore = [NSString stringWithFormat:@"  %ld分  高",scorenumber];
        showColor = [UIColor colorWithHexString:@"DD1A21"];

    }
    
    showText = rellyScore;
//    showText = [NSString stringWithFormat:@"%@%@",text,rellyScore];
    
    
//    NSRange range = [showText rangeOfString:rellyScore];
    

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:showText];
//    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0,range.location)];
    [attri addAttribute:NSForegroundColorAttributeName value:showColor range:NSMakeRange(0,rellyScore.length)];
    
    return attri;
    
}
- (void)clickCancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
