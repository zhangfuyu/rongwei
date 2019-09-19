//
//  DFTabBarController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef  NS_ENUM(NSInteger ,DCTabBarControllerType){
    DCTabBarControllerMeiXin = 0,  //美信
    DCTabBarControllerHome = 1, //首页
    DCTabBarControllerMediaList = 2,  //美媚榜
    DCTabBarControllerBeautyStore = 3, //美店
    DCTabBarControllerPerson = 4, //个人中心
};


@interface DFTabBarController : UITabBarController
/* 控制器type */
@property (assign , nonatomic)DCTabBarControllerType tabVcType;

@end

NS_ASSUME_NONNULL_END
