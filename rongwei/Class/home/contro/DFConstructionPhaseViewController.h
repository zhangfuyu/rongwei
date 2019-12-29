//
//  DFConstructionPhaseViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/24.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DFConstructionPhaseViewControllerDelegate <NSObject>
@optional

- (void)selectChooseStyleId:(NSString *)styleId;

@end

@interface DFConstructionPhaseViewController : DFBaseViewController

@property (nonatomic, weak)id<DFConstructionPhaseViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
