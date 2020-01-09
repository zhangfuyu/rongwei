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
#import "DFHomeNavModel.h"
#import "DFCategoryModel.h"
#import "DFMoreGoodsListViewController.h"

@interface DFBuildingHeaderView ()<SDCycleScrollViewDelegate>
@property (nonatomic , strong)SDCycleScrollView *scrollView;
@property (nonatomic , strong)UIImageView *firstiamge;
@property (nonatomic , strong)UIImageView *secondimage;

@property (nonatomic , strong)UIScrollView *imageScro;
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
    self.scrollView.imageSize = CGSizeMake(ScreenW, HScaleHeight(150));
    [self addSubview:self.scrollView];
    
//    NSArray *titleArry = @[@"卫浴",@"橱柜",@"家具",@"家电",@"门窗",@"地暖/空调",@"全屋定制",@"瓷砖",@"地板",@"智能家居"];
//    NSArray *imageArry = @[@"xiaoguotu",@"zhaosheji",@"zhaoshigong",@"maicailiao",@"chagonglue",@"suanbaojia",@"xiangzixun",@"yaojianli",@"zhihuijia",@"kanzhibo"];
//    
//    float interval = (ScreenW - HScaleWidth(30) - (HScaleWidth(44) * 5)) / 4;
//
//    
//    for (NSInteger index = 0; index < titleArry.count; index ++) {
//        DFHomeModuleButtonView *buttonView = [[DFHomeModuleButtonView alloc] initWithImageName:[imageArry objectOrNilAtIndex:index] withTitle:[titleArry objectOrNilAtIndex:index]];
//                   
//                  
//        [buttonView.actionButton addTarget:self action:@selector(clicksubButton:) forControlEvents:UIControlEventTouchUpInside];
//        buttonView.actionButton.tag = index;
//        [self addSubview:buttonView];
//        
//        float frameX = index % 5 * interval + (index % 5 * HScaleWidth(44)) + HScaleWidth(15);
//        
//        float frameY = index / 5 * HScaleHeight(62) + index / 5 * HScaleHeight(20) + HScaleHeight(150) + HScaleHeight(17);
//        
//        buttonView.frame = CGRectMake(frameX, frameY, HScaleWidth(44), HScaleHeight(62));
//        
//    }
    
    
    self.imageScro = [[UIScrollView alloc]init];
    self.imageScro.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
    self.imageScro.showsVerticalScrollIndicator = NO;
    self.imageScro.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.imageScro];
    
    [self.imageScro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(HScaleHeight(330));
        make.height.mas_equalTo(95);
    }];
    
    
//    self.firstiamge = [[UIImageView alloc]init];
//    self.firstiamge.backgroundColor = [UIColor orangeColor];
//    [backview addSubview:self.firstiamge];
//    [self.firstiamge mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(HScaleHeight(10));
//        make.size.mas_equalTo(CGSizeMake(HScaleWidth(172.5), HScaleHeight(75)));
//    }];
//
//    self.secondimage = [[UIImageView alloc]init];
//    self.secondimage.backgroundColor = [UIColor orangeColor];
//    [backview addSubview:self.secondimage];
//    [self.secondimage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(HScaleHeight(10));
//        make.right.mas_equalTo(-HScaleHeight(10));
//        make.size.mas_equalTo(CGSizeMake(HScaleWidth(172.5), HScaleHeight(75)));
//    }];
    
}

- (void)setNav_arry:(NSMutableArray *)nav_arry
{
    _nav_arry = nav_arry;
    
    float interval = (ScreenW - HScaleWidth(30) - (HScaleWidth(44) * 5)) / 4;
    
    
    
    for (NSInteger index = 0; index < nav_arry.count; index ++) {
        
        DFCategoryModel *model = nav_arry[index];
        
        DFHomeModuleButtonView *buttonView = [[DFHomeModuleButtonView alloc] initWithImageName:model.img_url withTitle:model.category_name];
                   
                  
        [buttonView.actionButton addTarget:self action:@selector(clicksubButton:) forControlEvents:UIControlEventTouchUpInside];
        buttonView.actionButton.tag = index;
        [self addSubview:buttonView];
        
        float frameX = index % 5 * interval + (index % 5 * HScaleWidth(44)) + HScaleWidth(15);
        
        float frameY = index / 5 * HScaleHeight(62) + index / 5 * HScaleHeight(20) + HScaleHeight(150) + HScaleHeight(17);
        
        buttonView.frame = CGRectMake(frameX, frameY, HScaleWidth(44), HScaleHeight(62));
        
    }
    
    
    
}

- (void)setDownbanaerArry:(NSMutableArray *)downbanaerArry
{
    _downbanaerArry = downbanaerArry;

    
    float jianju = (ScreenW - 2 * HScaleWidth(172.5)) / 3;
    
    for (NSInteger index = 0; index < downbanaerArry.count; index ++) {
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.backgroundColor = [UIColor orangeColor];
        [self.imageScro addSubview:imageview];
        DFHomeNavModel *model = [downbanaerArry objectAtIndex:index];
        [imageview sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:nil];
        
        UITapGestureRecognizer *noneTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectread:)];
        [imageview addGestureRecognizer:noneTapGR];
        imageview.tag = 10086 + index;
        [imageview setUserInteractionEnabled:YES];

        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((index + 1) * jianju + index * HScaleWidth(172.5));
            make.top.mas_equalTo(HScaleHeight(10));
            make.size.mas_equalTo(CGSizeMake(HScaleWidth(172.5), HScaleHeight(75)));
        }];

    }
    
        
    self.imageScro.contentSize = CGSizeMake((downbanaerArry.count + 1) * jianju + downbanaerArry.count *HScaleWidth(172.5), 0);
    

}

- (void)selectread:(UITapGestureRecognizer *)tap
{

    DFHomeNavModel *model = self.downbanaerArry[tap.view.tag - 10086];
    [[DFUserModelTool shareInstance] formeController:self.viewController withModel:model];
    
}

- (void)setBanaerArry:(NSMutableArray *)banaerArry
{
    _banaerArry = banaerArry;
    NSMutableArray *imageUrlArray = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger index = 0; index < banaerArry.count; index ++) {
        DFHomeNavModel *model = [banaerArry objectOrNilAtIndex:index];
        [imageUrlArray addObject:model.pic_url];
        
    }
    
    [self.scrollView setImageURLStringsGroup:imageUrlArray];
}

- (void)clicksubButton:(DFHomeModuleButtonView *)clickbtn
{
    NSLog(@"------>点击了第%ld个class",clickbtn.tag);
    DFCategoryModel *model = self.nav_arry[clickbtn.tag];

    
    
    DFMoreGoodsListViewController *goodslist = [[DFMoreGoodsListViewController alloc]init];
    goodslist.isCategory = YES;
    goodslist.category_id = model.modelid;
    [self.viewController.navigationController pushViewController:goodslist animated:YES];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
   DFHomeNavModel *model = self.banaerArry[index];
   
   [[DFUserModelTool shareInstance] formeController:self.viewController withModel:model];
    
}
@end
