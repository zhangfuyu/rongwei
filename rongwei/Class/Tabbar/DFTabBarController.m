//
//  DFTabBarController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFTabBarController.h"
#import "DFNavigationController.h"

@interface DFTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSMutableArray *tabBarItems;
//给item加上badge
@property (nonatomic, weak) UITabBarItem *item;

@end

@implementation DFTabBarController

- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    
    return _tabBarItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self addDcChildViewContorller];
    
}
#pragma mark - 添加子控制器

- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"DFHomeViewController",
                              MallTitleKey  : @"首页",
                              MallImgKey    : @"jiaj11u",
                              MallSelImgKey : @"jiaj11u"},
                            
                            @{MallClassKey  : @"DFXiaoGuoTuViewController",
                              MallTitleKey  : @"效果图",
                              MallImgKey    : @"rendering",
                              MallSelImgKey : @"rendering"},
                            
                            @{MallClassKey  : @"DFJianCaiViewController",
                              MallTitleKey  : @"建材库",
                              MallImgKey    : @"jiaju-kongtiao",
                              MallSelImgKey : @"jiaju-kongtiao"},
                            
                            @{MallClassKey  : @"DFFindGonglueViewController",
                              MallTitleKey  : @"找攻略",
                              MallImgKey    : @"jiaju-dengpao",
                              MallSelImgKey : @"jiaju-dengpao"},
                            
                            @{MallClassKey  : @"DFMainViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"jiaju",
                              MallSelImgKey : @"jiaju"},
                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        DFNavigationController *nav = [[DFNavigationController alloc] initWithRootViewController:vc];
        nav.navigationItem.title = dict[MallTitleKey];
        UITabBarItem *item = nav.tabBarItem;
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
        item.title = dict[MallTitleKey];
        [self addChildViewController:nav];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
        
      
//        WEAKSELF
//        if ([dict[MallTitleKey] isEqualToString:@"美信"]) {
//            weakSelf.beautyMsgVc = (DCBeautyMessageViewController *)vc; //给美信赋值
//        }
        
        // 添加tabBarItem至数组
        [self.tabBarItems addObject:vc.tabBarItem];
    }];
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
