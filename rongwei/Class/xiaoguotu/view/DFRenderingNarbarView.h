//
//  DFRenderingNarbarView.h
//  rongwei
//
//  Created by apple on 2019/10/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
   
    DFconditions_Rendering  = 0, //效果图
    DFconditions_LocalFigure = 1,//局部图
    DFconditions_DecorateACase =2,//装修案例
    
} DFconditions;

@interface DFRenderingNarbarView : UIView

@property (nonatomic , copy) void (^chooseConditionsBlock)(DFconditions conditon);

@property (nonatomic , assign) DFconditions sTraTegyStyle;

@end

NS_ASSUME_NONNULL_END
