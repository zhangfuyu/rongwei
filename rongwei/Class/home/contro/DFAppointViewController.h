//
//  DFAppointViewController.h
//  rongwei
//
//  Created by apple on 2019/11/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DFAppointViewControllerDelegate <NSObject>

@optional
- (void)FillInTheInformation;

@end

@interface DFAppointViewController : DFBaseViewController

@property (nonatomic , weak) id<DFAppointViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
