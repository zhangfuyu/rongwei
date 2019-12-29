//
//  DFInformationViewController.m
//  rongwei
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFInformationViewController.h"

@interface DFInformationViewController ()<UIScrollViewDelegate>

@end

@implementation DFInformationViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.scrollView.contentSize.height < ScreenH - kNavBarAndStatusBarHeight - kBottomSafeHeight - HScaleHeight(40)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Special" object:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
 
        make.edges.equalTo(self.view).mas_equalTo(0);
        
    }];
    
    
    UILabel *firstlabel1 = [[UILabel alloc]init];
    firstlabel1.text = @"公司简介";
    firstlabel1.font = HScaleBoldFont(14);
    firstlabel1.textColor = [UIColor colorWithHexString:@"333333"];
    [self.scrollView addSubview:firstlabel1];
    
    [firstlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scrollView.mas_left).offset(HScaleWidth(17));
        make.top.equalTo(self.scrollView).mas_equalTo(0);;
    }];
    
    UILabel *sccondlabel1 = [[UILabel alloc]init];
    sccondlabel1.text = self.model.brief;
    sccondlabel1.font = HScaleFont(12);
    sccondlabel1.numberOfLines = 0;
    sccondlabel1.textColor = [UIColor colorWithHexString:@"666666"];
    [self.scrollView addSubview:sccondlabel1];
    
    [sccondlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstlabel1.mas_left);
        make.top.mas_equalTo(firstlabel1.mas_bottom).offset(HScaleHeight(10));
        make.width.mas_equalTo(ScreenW - HScaleWidth(34));
    }];
    
    
    UILabel *firstlabel = [[UILabel alloc]init];
    firstlabel.text = @"承接户型";
    firstlabel.font = HScaleBoldFont(14);
    firstlabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.scrollView addSubview:firstlabel];
    
    [firstlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scrollView.mas_left).offset(HScaleWidth(17));
        make.top.mas_equalTo(sccondlabel1.mas_bottom).offset(HScaleHeight(25));
    }];
    
    UILabel *sccondlabel = [[UILabel alloc]init];
    sccondlabel.text = self.model.shapes;
    sccondlabel.font = HScaleFont(12);
    sccondlabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.scrollView addSubview:sccondlabel];
    
    [sccondlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstlabel.mas_left);
        make.top.mas_equalTo(firstlabel.mas_bottom).offset(HScaleHeight(10));
        make.right.mas_equalTo(self.scrollView.mas_right).offset(-HScaleWidth(12));
    }];
    
    UILabel *threelabel = [[UILabel alloc]init];
    threelabel.text = @"服务区域";
    threelabel.font = HScaleBoldFont(14);
    threelabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.scrollView addSubview:threelabel];
    
    [threelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
        make.left.mas_equalTo(firstlabel.mas_left);
        make.top.mas_equalTo(sccondlabel.mas_bottom).offset(HScaleHeight(25));
    }];
    
    UILabel *fourlabel = [[UILabel alloc]init];
    fourlabel.text = self.model.address;
    fourlabel.font = HScaleFont(12);
    fourlabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.scrollView addSubview:fourlabel];
    
    [fourlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(threelabel.mas_left);
        make.top.mas_equalTo(threelabel.mas_bottom).offset(HScaleHeight(10));

    }];
    
    UILabel *fivelabel = [[UILabel alloc]init];
    fivelabel.text = @"公司规模";
    fivelabel.font = HScaleBoldFont(14);
    fivelabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.scrollView addSubview:fivelabel];
    
    [fivelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstlabel.mas_left);
        make.top.mas_equalTo(fourlabel.mas_bottom).offset(HScaleHeight(25));
    }];
    
    UILabel *sixlabel = [[UILabel alloc]init];
    sixlabel.text = [NSString stringWithFormat:@"%@",self.model.scale];
    sixlabel.font = HScaleFont(12);
    sixlabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.scrollView addSubview:sixlabel];
    
    [sixlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(fivelabel.mas_left);
        make.top.mas_equalTo(fivelabel.mas_bottom).offset(HScaleHeight(10));

    }];
    
//    UILabel *sevenlabel = [[UILabel alloc]init];
//    sevenlabel.text = @"工商注册信息";
//    sevenlabel.font = HScaleBoldFont(14);
//    sevenlabel.textColor = [UIColor colorWithHexString:@"333333"];
//    [self.scrollView addSubview:sevenlabel];
//
//    [sevenlabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(firstlabel.mas_left);
//        make.top.mas_equalTo(sixlabel.mas_bottom).offset(HScaleHeight(25));
//    }];
    
//    UIImageView *firseimage = [[UIImageView alloc]init];
//    [firseimage sd_setImageWithURL:[NSURL URLWithString:self.model.business_license_pic] placeholderImage:nil];
//    [self.scrollView addSubview:firseimage];
//    
//    [firseimage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(sevenlabel.mas_left);
//        make.top.mas_equalTo(sevenlabel.mas_bottom).offset(HScaleHeight(10));
//        make.size.mas_equalTo(CGSizeMake(HScaleWidth(196), HScaleHeight(147)));
//    }];
   
    
    UILabel *eightlabel = [[UILabel alloc]init];
    eightlabel.text = @"营业执照 ";
    eightlabel.font = HScaleBoldFont(14);
    eightlabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.scrollView addSubview:eightlabel];
    
    [eightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstlabel.mas_left);
        make.top.mas_equalTo(sixlabel.mas_bottom).offset(HScaleHeight(20));
    }];
    
    UIImageView *secondimage = [[UIImageView alloc]init];
    [secondimage sd_setImageWithURL:[NSURL URLWithString:self.model.business_license_pic] placeholderImage:nil];
    [self.scrollView addSubview:secondimage];
    
    [secondimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(eightlabel.mas_left);
        make.top.mas_equalTo(eightlabel.mas_bottom).offset(HScaleHeight(10));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(196), HScaleHeight(147)));
        make.bottom.equalTo(self.scrollView).mas_equalTo(0);
        
    }];
    

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
//    self.scrollView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
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
