//
//  DFNavigationController.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFNavigationController.h"

@interface DFNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation DFNavigationController
+ (void)load
{
    [self setUpBase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf = self;

   if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
          
          self.interactivePopGestureRecognizer.delegate = weakSelf;
      }
    
    [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:nil];

//    self.navigationBar.translucent = YES;

}
#pragma mark - 初始化
+ (void)setUpBase
{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor colorWithHexString:@"FFFFFF"];//DCBGColor;
    [bar setTintColor:[UIColor darkGrayColor]];
    bar.translucent = YES;
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = [UIColor blackColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = HScaleFont(18);
    bar.titleTextAttributes = attributes;
}
#pragma mark - 返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(20, 20, 33, 33);
        
//        if (@available(ios 11.0,*)) {
//            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
//        }
        
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItem = backButton;//@[negativeSpacer, backButton];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
      
    }
       
       
    //跳转
    [super pushViewController:viewController animated:animated];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }else{
        return YES;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
//使navigationcontroller中第一个控制器不响应右滑pop手势
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark - 点击
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
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
