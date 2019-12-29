//
//  DFAreaViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DFAreaViewControllerDelegate <NSObject>
@optional

- (void)selectChooseAreaStyleId:(NSString *)styleId;

@end

@interface DFAreaViewController : DFBaseViewController

@property (nonatomic , weak)id<DFAreaViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
