//
//  DFHomeHeaderView.m
//  rongwei
//
//  Created by apple on 2019/10/14.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFHomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "DFHomeModuleButtonView.h"

@interface DFHomeHeaderView()<SDCycleScrollViewDelegate>

@property (nonatomic , strong)SDCycleScrollView *scrollView;

@property (nonatomic , strong)SDCycleScrollView *recommended;

@end

@implementation DFHomeHeaderView

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
        
        [self creatui];
    }
    return self;
}
- (void)creatui
{
    UIImageView *imageview = [[UIImageView alloc]init];
    [imageview setImage:[UIImage imageNamed:@"框_home_header"]];
    [self addSubview:imageview];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(196);
    }];
    
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
       locationButton.titleLabel.font = HScaleFont(14);
       locationButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
       [locationButton setTitle:@"正在定位" forState:UIControlStateNormal];
       [locationButton setImage:[UIImage imageNamed:@"home_arrow_down"] forState:UIControlStateNormal];
       [locationButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
       [locationButton addTarget:self action:@selector(clickLocationAction) forControlEvents:UIControlEventTouchUpInside];
       locationButton.transform = CGAffineTransformMakeScale(-1, 1);
       locationButton.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
       locationButton.imageView.transform = CGAffineTransformMakeScale(-1, 1);
       [locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
       [self addSubview:locationButton];
       
       [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(kStatusBarHeight);
           make.left.mas_equalTo(0);
           make.height.mas_equalTo(kNavBarHeight);
           make.width.mas_equalTo(80);
       }];
       
       
       
       self.locationButton = locationButton;
       
       UITextField *searchTextField = [[UITextField alloc] init];
       searchTextField.backgroundColor = [UIColor whiteColor];
       searchTextField.layer.cornerRadius = HScaleHeight(14);
       searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
       searchTextField.font = HScaleFont(12);
       searchTextField.textColor = [UIColor colorWithHexString:@"999999"];
       searchTextField.placeholder = @"找施工、设计师、主材";
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
           make.left.mas_equalTo(locationButton.mas_right).offset(6);
//           make.top.mas_equalTo(HScaleHeight(13)+ kStatusBarHeight);
           make.centerY.mas_equalTo(self.locationButton.mas_centerY);
           make.height.mas_equalTo(HScaleHeight(28));
           make.right.mas_equalTo(-54);
       }];
       
    
    
    UIButton *noticeMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
       [noticeMessageButton setImage:[UIImage imageNamed:@"home_notice"] forState:UIControlStateNormal];
       [self addSubview:noticeMessageButton];
       
       [noticeMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(kStatusBarHeight);
           make.right.mas_equalTo(0);
           make.height.mas_equalTo(kNavBarHeight);
           make.left.mas_equalTo(searchTextField.mas_right);
       }];
       
       [noticeMessageButton addTarget:self action:@selector(clickNoticeAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
     self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(HScaleHeight(10), HScaleHeight(50) + kStatusBarHeight , ScreenW - HScaleHeight(20), HScaleHeight(150)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
     self.scrollView.autoScrollTimeInterval = 5;
     self.scrollView.layer.cornerRadius = HScaleHeight(5);
     self.scrollView.backgroundColor = [UIColor whiteColor];
     self.scrollView.currentPageDotColor = [UIColor whiteColor];
//    scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
     self.scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
     self.scrollView.pageControlBottomOffset = 12;
     self.scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:.6];
     self.scrollView.currentPageDotColor = [UIColor whiteColor];
     self.scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
     self.scrollView.imageSize = CGSizeMake(ScreenW - HScaleHeight(20), HScaleHeight(150));
     [self addSubview:self.scrollView];
    
    NSArray *titleArry = @[@"效果图",@"找设计",@"找施工",@"买材料",@"查攻略",@"算报价",@"想咨询",@"要监理",@"智慧家",@"看直播"];
    NSArray *imageArry = @[@"xiaoguotu",@"zhaosheji",@"zhaoshigong",@"maicailiao",@"chagonglue",@"suanbaojia",@"xiangzixun",@"yaojianli",@"zhihuijia",@"kanzhibo"];
    
    
    float interval = (ScreenW - HScaleWidth(30) - (HScaleWidth(44) * 5)) / 4;
    
    for (NSInteger index = 0; index < titleArry.count; index ++) {
        DFHomeModuleButtonView *buttonView = [[DFHomeModuleButtonView alloc] initWithImageName:[imageArry objectOrNilAtIndex:index] withTitle:[titleArry objectOrNilAtIndex:index]];
                   
                  
        [buttonView.actionButton addTarget:self action:@selector(clicksubButton:) forControlEvents:UIControlEventTouchUpInside];
        buttonView.actionButton.tag = index;
        [self addSubview:buttonView];
        
        float frameX = index % 5 * interval + (index % 5 * HScaleWidth(44)) + HScaleWidth(15);
        
        float frameY = index / 5 * HScaleHeight(62) + index / 5 * HScaleHeight(20) + HScaleHeight(150) + HScaleHeight(17) + kNavBarAndStatusBarHeight;
        
        buttonView.frame = CGRectMake(frameX, frameY, HScaleWidth(44), HScaleHeight(62));
        
    }
    
    
    UIImageView *noorderimage = [[UIImageView alloc]init];
    noorderimage.image = [UIImage imageNamed:@"noorder"];
    [self addSubview:noorderimage];
    
    [noorderimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleWidth(13));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(9), HScaleHeight(9)));
        make.top.mas_equalTo(HScaleHeight(385 )+ kStatusBarHeight);
    }];
    
    UILabel *firstLabel = [[UILabel alloc]init];
    firstLabel.text = @"没有中间商（装修公司）";
    firstLabel.font = HScaleFont(10);
    firstLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self addSubview:firstLabel];
    
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noorderimage.mas_right).offset(HScaleWidth(1));
        make.height.mas_equalTo(HScaleHeight(10));
        make.centerY.mas_equalTo(noorderimage.mas_centerY);
    }];
    
    
    UIImageView *lirun_xin = [[UIImageView alloc]init];
    lirun_xin.image = [UIImage imageNamed:@"lirun-xin"];
    [self addSubview:lirun_xin];
   
    [lirun_xin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstLabel.mas_right).offset(HScaleWidth(35));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(9), HScaleHeight(9)));
        make.top.mas_equalTo(HScaleHeight(385 )+ kStatusBarHeight);
    }];
   
    UILabel *second = [[UILabel alloc]init];
    second.text = @"装修资金平台托管";
    second.font = HScaleFont(10);
    second.textColor = [UIColor colorWithHexString:@"333333"];
    [self addSubview:second];
   
    [second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lirun_xin.mas_right).offset(HScaleWidth(1));
        make.height.mas_equalTo(HScaleHeight(10));
        make.centerY.mas_equalTo(lirun_xin.mas_centerY);
    }];
    
    
    UIImageView *baozhang = [[UIImageView alloc]init];
     baozhang.image = [UIImage imageNamed:@"lirun-xin"];
     [self addSubview:baozhang];
    
     [baozhang mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(second.mas_right).offset(HScaleWidth(35));
         make.size.mas_equalTo(CGSizeMake(HScaleWidth(9), HScaleHeight(9)));
         make.top.mas_equalTo(HScaleHeight(385 )+ kStatusBarHeight);
     }];
    
     UILabel *threeLabel = [[UILabel alloc]init];
     threeLabel.text = @"平台质检质保";
     threeLabel.font = HScaleFont(10);
     threeLabel.textColor = [UIColor colorWithHexString:@"333333"];
     [self addSubview:threeLabel];
    
     [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(baozhang.mas_right).offset(HScaleWidth(1));
         make.height.mas_equalTo(HScaleHeight(10));
         make.centerY.mas_equalTo(lirun_xin.mas_centerY);
     }];
    
    
    self.recommended = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(HScaleHeight(10), HScaleHeight(405) + kStatusBarHeight , ScreenW - HScaleHeight(10), HScaleHeight(101)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    self.recommended.autoScrollTimeInterval = 5;
    self.recommended.layer.cornerRadius = HScaleHeight(5);
    self.recommended.backgroundColor = [UIColor whiteColor];
//    self.recommended.currentPageDotColor = [UIColor whiteColor];
    self.recommended.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
//    self.recommended.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
//    self.recommended.pageControlBottomOffset = 12;
//    self.recommended.pageDotColor = [UIColor colorWithWhite:1 alpha:.6];
//    self.recommended.currentPageDotColor = [UIColor whiteColor];
    self.recommended.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.recommended.imageSize = CGSizeMake(HScaleHeight(310), HScaleHeight(100));
    
    [self addSubview:self.recommended];
     [self.recommended setImageURLStringsGroup:@[]];
}

- (void)clicksubButton:(UIButton *)clickBtn
{
    //效果图
    if (clickBtn.tag == 0) {
        [self.viewController.tabBarController setSelectedIndex:1];
    }
}

/// 定位
- (void)clickLocationAction
{
    
}

/// 消息
- (void)clickNoticeAction
{
    
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
   
    
}

@end
