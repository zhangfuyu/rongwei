//
//  DFXiaoGuoStyleViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@protocol DFXiaoGuoStyleViewControllerDelegate <NSObject>
@optional

- (void)selectChooseStyleId:(NSString *)styleId withText:(NSString *)text;

@end

@interface DFXiaoGuoStyleViewController : DFBaseViewController

@property (nonatomic , weak)id<DFXiaoGuoStyleViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
