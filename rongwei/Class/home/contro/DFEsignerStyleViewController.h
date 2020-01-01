//
//  DFEsignerStyleViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/30.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DFEsignerStyleViewControllerDelegate <NSObject>
@optional

- (void)selectChooseEsignerStyleId:(NSString *)styleId withText:(NSString *)text;

@end

@interface DFEsignerStyleViewController : DFBaseViewController

@property (nonatomic , weak)id<DFEsignerStyleViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
