//
//  DFUserModelTool.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "DFUserModelTool.h"

#import "DFLoginViewController.h"

#import "DFCityModel.h"

#import "DFSaveDataTool.h"


#import "DFGoodsDetailViewController.h"
#import "DFStrategyDetailViewController.h"
#import "DFZiXunListViewController.h"
#import "DFWorksDetailViewController.h"
#import "DFLookMorePictureViewController.h"
#import "DFDesignerModel.h"
#import "DFEsignerDetialViewController.h"
#import "DFContructionDetailViewController.h"
#import "DFStoreDetailViewController.h"
#import "DFWebViewController.h"

@implementation DFUserModelTool

+ (instancetype)shareInstance
{
    static DFUserModelTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[DFUserModelTool alloc] init];
        _tool.isHaveNetwork = true;
    });
    return _tool;
}

- (void)showLoginViewController
{
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[DFLoginViewController new]];
//    [[[DFUserModelTool shareInstance] getCurrentVC] presentViewController:nav animated:YES completion:nil];
    [[[DFUserModelTool shareInstance] getCurrentVC].navigationController pushViewController:[DFLoginViewController new] animated:YES];
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [self getViewControllerWindow].rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

//获取RootViewController所在的window
- (UIWindow*)getViewControllerWindow{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *target in windows) {
            if (target.windowLevel == UIWindowLevelNormal) {
                window = target;
                break;
            }
        }
    }
    return window;
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        while ([rootVC presentedViewController]) {
            rootVC = [rootVC presentedViewController];
        }
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
        
    }
    
    return currentVC;
}
- (NSMutableArray *)banaerArry
{
    if (!_banaerArry) {
        _banaerArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _banaerArry;
}
- (NSMutableArray *)navDownArry
{
    if (!_navDownArry) {
        _navDownArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _navDownArry;
}
- (NSMutableArray *)hotArry
{
    if (!_hotArry) {
        _hotArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _hotArry;
}

- (void)getcitydata
{
    
    NSDictionary *citydic = [[DFSaveDataTool shareInstance] getCountryData];
    
    if (citydic == nil) {
            [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:regions withParameter:@{@"type":@"tree"} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            if (isSuccess) {
                
                NSDictionary *datadic = response[@"data"];
                
                [[DFSaveDataTool shareInstance] saveCountryDataWithData:datadic];
                

                
                
            }
        }];
    }
    
    
    NSArray *allkey = citydic.allKeys;

    NSMutableArray *provinceArry = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger index = 0; index < allkey.count; index ++) {
        NSString *indexKey = allkey[index];
        NSDictionary *keyData = citydic[indexKey];
        DFCityModel *provinceModel = [[DFCityModel alloc]initWithDictionary:keyData error:nil];
        [provinceArry addObject:provinceModel];
    }
    
    

}

- (void)formeController:(UIViewController *)controller withModel:(DFHomeNavModel *)model
{
    
    NSData *jsonData = [model.custom dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
   if ([model.ios_activity isEqualToString:@"goGoodDetail"]) {
        DFGoodsDetailViewController *goodDetail = [[DFGoodsDetailViewController alloc]init];
        goodDetail.goods_id = dic[@"id"];
        [controller.navigationController pushViewController:goodDetail animated:YES];
    }
    else if ([model.ios_activity isEqualToString:@"goStrategyDetail"])
    {
        DFStrategyDetailViewController *detail = [[DFStrategyDetailViewController alloc]init];
        detail.modelid = dic[@"id"];
        [controller.navigationController pushViewController:detail animated:YES];
    }
    else if ([model.ios_activity isEqualToString:@"goConsultingDetail"])
    {
        DFZiXunListViewController *zixun = [[DFZiXunListViewController alloc]init];
        zixun.modelID = dic[@"id"];
        [controller.navigationController pushViewController:zixun animated:YES];
    }
    else if ([model.ios_activity isEqualToString:@"goWorksDetail"])
    {
        DFWorksDetailViewController *worksdetail = [[DFWorksDetailViewController alloc]init];
        worksdetail.worksId = dic[@"id"];
        worksdetail.autherID = dic[@"p_id"];
        [controller.navigationController pushViewController:worksdetail animated:YES];
    }
    else if ([model.ios_activity isEqualToString:@"goRenderingDetail"])
    {
        DFLookMorePictureViewController *morePicture = [[DFLookMorePictureViewController alloc]init];
        morePicture.workId = dic[@"id"];
        [controller.navigationController pushViewController:morePicture animated:YES];
    }
    else if ([model.ios_activity isEqualToString:@"goDesignerDetail"])
    {
        DFEsignerDetialViewController *Esigner = [[DFEsignerDetialViewController alloc]init];
        DFDesignerModel *esignerModel = [[DFDesignerModel alloc]init];
        esignerModel.modelId = dic[@"id"];
        Esigner.model = esignerModel;
        [controller.navigationController pushViewController:Esigner animated:YES];
    }
    else if ([model.ios_activity isEqualToString:@"goCompanyDetail"])
    {
        DFContructionDetailViewController *morePicture = [[DFContructionDetailViewController alloc]init];
        morePicture.shop_id = dic[@"id"];
        [controller.navigationController pushViewController:morePicture animated:YES];
    }
    else if ([model.ios_activity isEqualToString:@"goStoreDetail"])
    {
        DFStoreDetailViewController *storedetail = [[DFStoreDetailViewController alloc]init];
        storedetail.store_id = dic[@"id"];
        [controller.navigationController pushViewController:storedetail animated:YES];
    }
    else if ([model.ios_activity isEqualToString:@"goWebView"])
    {
        DFWebViewController *webview = [[DFWebViewController alloc]init];
        webview.requestUrl = model.url;
        [controller.navigationController pushViewController:webview animated:YES];
    }
        
    //    1.商品详情页
    //    2.攻略详情页
    //    3.咨询详情页
    //    4.作品详情页   暂时写不了 缺少作者id
    //    5.效果图详情页
    //    6.设计师主页
    //    7.施工公司主页
    //    8.店铺主页
    //    9.分享达人主页
    //    10.H5页面
}

@end
