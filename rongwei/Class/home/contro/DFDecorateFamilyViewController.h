//
//  DFDecorateFamilyViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/24.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DFDecorateFamilyViewControllerDelegate <NSObject>
@optional

- (void)selectChooseDoorModelStyleId:(NSString *)styleId withText:(NSString *)text;

@end

@interface DFDecorateFamilyViewController : DFBaseViewController

@property (nonatomic , weak)id<DFDecorateFamilyViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
