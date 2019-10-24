//
//  DFBuildingHeaderView.m
//  rongwei
//
//  Created by apple on 2019/10/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFBuildingHeaderView.h"
#import "SDCycleScrollView.h"
#import "DFHomeModuleButtonView.h"

@interface DFBuildingHeaderView ()<SDCycleScrollViewDelegate>
@property (nonatomic , strong)SDCycleScrollView *scrollView;
@end

@implementation DFBuildingHeaderView

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
        self.backgroundColor = [UIColor whiteColor];
        [self creatui];
    }
    return self;
}
- (void)creatui
{
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, HScaleHeight(150)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    self.scrollView.autoScrollTimeInterval = 5;
    self.scrollView.layer.cornerRadius = HScaleHeight(5);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.currentPageDotColor = [UIColor whiteColor];
//   scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.scrollView.pageControlBottomOffset = 12;
    self.scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:.6];
    self.scrollView.currentPageDotColor = [UIColor whiteColor];
    self.scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.scrollView.imageSize = CGSizeMake(ScreenW - HScaleHeight(20), HScaleHeight(150));
    [self addSubview:self.scrollView];
    
    NSArray *titleArry = @[@"卫浴",@"橱柜",@"家具",@"家电",@"门窗",@"地暖/空调",@"全屋定制",@"瓷砖",@"地板",@"智能家居"];
    NSArray *imageArry = @[@"xiaoguotu",@"zhaosheji",@"zhaoshigong",@"maicailiao",@"chagonglue",@"suanbaojia",@"xiangzixun",@"yaojianli",@"zhihuijia",@"kanzhibo"];
    
    float interval = (ScreenW - HScaleWidth(30) - (HScaleWidth(44) * 5)) / 4;

    
    for (NSInteger index = 0; index < titleArry.count; index ++) {
        DFHomeModuleButtonView *buttonView = [[DFHomeModuleButtonView alloc] initWithImageName:[imageArry objectOrNilAtIndex:index] withTitle:[titleArry objectOrNilAtIndex:index]];
                   
                  
        [buttonView.actionButton addTarget:self action:@selector(clicksubButton:) forControlEvents:UIControlEventTouchUpInside];
        buttonView.actionButton.tag = index;
        [self addSubview:buttonView];
        
        float frameX = index % 5 * interval + (index % 5 * HScaleWidth(44)) + HScaleWidth(15);
        
        float frameY = index / 5 * HScaleHeight(62) + index / 5 * HScaleHeight(20) + HScaleHeight(150) + HScaleHeight(17);
        
        buttonView.frame = CGRectMake(frameX, frameY, HScaleWidth(44), HScaleHeight(62));
        
    }
    
    
    UIView *backview = [[UIView alloc]init];
    backview.backgroundColor = [UIColor colorWithHexString:@"333333"];
    [self addSubview:backview];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(HScaleHeight(330));
        make.height.mas_equalTo(95);
    }];
    
    UIImageView *firstiamge = [[UIImageView alloc]init];
    firstiamge.backgroundColor = [UIColor orangeColor];
    [backview addSubview:firstiamge];
    [firstiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(HScaleHeight(10));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(172.5), HScaleHeight(75)));
    }];
    
    UIImageView *secondimage = [[UIImageView alloc]init];
    secondimage.backgroundColor = [UIColor orangeColor];
    [backview addSubview:secondimage];
    [secondimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HScaleHeight(10));
        make.right.mas_equalTo(-HScaleHeight(10));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(172.5), HScaleHeight(75)));
    }];
    
}

- (void)clicksubButton:(DFHomeModuleButtonView *)clickbtn
{
    
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
   
    
}
@end
