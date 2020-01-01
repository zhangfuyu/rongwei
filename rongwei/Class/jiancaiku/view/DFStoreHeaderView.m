//
//  DFStoreHeaderView.m
//  rongwei
//
//  Created by zhangfuyu on 2019/12/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFStoreHeaderView.h"
#import "SDCycleScrollView.h"
#import "DFStoreMoreDetailViewController.h"



@interface DFStoreHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic , strong) DFStoreModel *detailModel;

@property (nonatomic , strong) UIImageView *backImage;

@property (nonatomic , strong) NSMutableArray *clickBtnArry;

@property (nonatomic , assign) BOOL isSelectPrice;

@end

@implementation DFStoreHeaderView

- (instancetype)initWithFrame:(CGRect)frame withModel:(DFStoreModel *)model
{
    if (self = [super initWithFrame:frame]) {
        
        self.detailModel = model;
        [self creatUI];
    }
    return self;
}
- (void)creatUI
{
    self.backImage = [[UIImageView alloc]init];
    if (self.detailModel.carousel_image.count > 0) {
        [self.backImage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.carousel_image[0]] placeholderImage:nil];

    }
    [self addSubview:self.backImage];
    
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];

    effectView.alpha = .9;

    [self addSubview:effectView];
    
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
                
        make.left.top.right.bottom.mas_equalTo(0);

    }];
    
    
    
    UIImageView *logoimage = [[UIImageView alloc]init];
    [logoimage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.logo_image] placeholderImage:nil];
    [self addSubview:logoimage];
    
    [logoimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HScaleWidth(55) + kStatusBarHeight);
        make.left.mas_equalTo(HScaleWidth(16));
        make.size.mas_equalTo(CGSizeMake(HScaleWidth(49), HScaleHeight(49)));
    }];
    
    UILabel *storeName = [[UILabel alloc]init];
    storeName.font = HScaleFont(15);
    storeName.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    storeName.text = self.detailModel.shop_name;
    [self addSubview:storeName];
    
    [storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoimage.mas_right).offset(HScaleWidth(15.5));
        make.top.mas_equalTo(logoimage.mas_top).offset(HScaleHeight(3.5));
        make.right.mas_equalTo(-HScaleWidth(90));
    }];
    
    UILabel *businessLabel = [[UILabel alloc]init];
    businessLabel.font = HScaleFont(12);
    businessLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    businessLabel.text = self.detailModel.shop_name;
    businessLabel.text = [NSString stringWithFormat:@"主营业务:%@",self.detailModel.shop_category];
    [self addSubview:businessLabel];
    
    [businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoimage.mas_right).offset(HScaleWidth(15.5));
        make.top.mas_equalTo(storeName.mas_bottom).offset(HScaleHeight(11));
        make.right.mas_equalTo(-HScaleWidth(90));
    }];
    
    
    
    UIView *clickView = [[UIView alloc]init];
    clickView.backgroundColor = [UIColor clearColor];
    [self addSubview:clickView];
    
    [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(logoimage.mas_top);
        make.bottom.mas_equalTo(logoimage.mas_bottom);
    }];
    
    UITapGestureRecognizer *noneTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMoreStoreDetail)];
    [clickView addGestureRecognizer:noneTapGR];
    
    
    
    
    SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(HScaleWidth(9.5), HScaleWidth(110) + kStatusBarHeight, ScreenW - HScaleWidth(19), HScaleHeight(150)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    banner.autoScrollTimeInterval = 5;
    banner.layer.cornerRadius = HScaleHeight(5);
    banner.backgroundColor = [UIColor whiteColor];
    banner.currentPageDotColor = [UIColor whiteColor];
//   scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    banner.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
    banner.pageControlBottomOffset = 12;
    banner.pageDotColor = [UIColor colorWithWhite:1 alpha:.6];
    banner.currentPageDotColor = [UIColor whiteColor];
    banner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    banner.imageSize = CGSizeMake(ScreenW - HScaleHeight(19), HScaleHeight(150));
    [self addSubview:banner];

    NSMutableArray *imageUrlArray = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger index = 0; index < self.detailModel.carousel_image.count; index ++) {
        NSString *imageUrl = self.detailModel.carousel_image[index];
        [imageUrlArray addObject:imageUrl];
        
    }
    
    [banner setImageURLStringsGroup:imageUrlArray];
    
    
    NSArray *selectBtnTitle = [NSArray arrayWithObjects:@"综合",@"销量",@"价格↑",@"新品优先", nil];
        
    for (NSInteger index = 0; index < selectBtnTitle.count; index ++) {
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
        [self addSubview:backView];
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(banner.mas_bottom);
            make.left.mas_equalTo((ScreenW-HScaleWidth(19))/4 * index + HScaleWidth(9.5));
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo((ScreenW-HScaleWidth(19))/4);
            
        }];
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (index == 2) {
            [clickBtn setTitle:@"价格↓" forState:UIControlStateSelected];
            clickBtn.selected = NO;

        }
        [clickBtn setTitle:selectBtnTitle[index] forState:UIControlStateNormal];
        clickBtn.tag = 10086 + index;
        [clickBtn addTarget:self action:@selector(ClickBtnChangeType:) forControlEvents:UIControlEventTouchUpInside];
        [clickBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        clickBtn.titleLabel.font = HScaleFont(12);
//        [clickBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"DD1A21"] size:CGSizeMake([(NSString *)selectBtnTitle[index] widthForFont:HScaleFont(12)] + HScaleWidth(19), HScaleHeight(20))] forState:UIControlStateSelected];
//        [clickBtn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateSelected];
        [backView addSubview:clickBtn];
        
        if (index == 0) {
            clickBtn.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
        }
        
        [backView addSubview:clickBtn];
        
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backView.mas_centerX);
            make.centerY.mas_equalTo(backView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake([(NSString *)selectBtnTitle[index] widthForFont:HScaleFont(12)] + HScaleWidth(19) , HScaleHeight(20)));
        }];
        
        [self.clickBtnArry addObject:clickBtn];
    }
    
    
}
- (void)ClickBtnChangeType:(UIButton *)sender
{
    for (UIButton *btn in self.clickBtnArry) {
        if (btn.tag == sender.tag) {
                       
            if (btn.tag - 10086 == 2) {
                
                if (self.isSelectPrice) {
                    btn.selected = !btn.selected;

                }
                self.isSelectPrice = YES;
            }
            
            
            btn.backgroundColor = [UIColor colorWithHexString:@"DD1A21"];
            
        


        }
        else
        {
            btn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];

        }
    }
    
    if (self.selectTypeBtn) {
        if (sender.tag - 10086 == 2) {
            if (sender.selected) {
                self.selectTypeBtn(sender.tag - 10086,@"价格↓");

            }
            else
            {
                self.selectTypeBtn(sender.tag - 10086,@"价格↑");

            }
        }
        else
        {
            self.selectTypeBtn(sender.tag - 10086,sender.titleLabel.text);

        }
    }
}
- (void)pushMoreStoreDetail
{
    DFStoreMoreDetailViewController *moreDetail = [[DFStoreMoreDetailViewController alloc]init];
    moreDetail.model = self.detailModel;
    [self.viewController.navigationController pushViewController:moreDetail animated:YES];
    
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
   
    
}
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.carousel_image[index]] placeholderImage:nil];
}


- (NSMutableArray *)clickBtnArry
{
    if (!_clickBtnArry) {
        _clickBtnArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _clickBtnArry;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
