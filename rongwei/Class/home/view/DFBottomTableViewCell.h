//
//  DFBottomTableViewCell.h
//  rongwei
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFPageContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFBottomTableViewCell : UITableViewCell

@property (nonatomic, strong) DFPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;
@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) NSString *currentTagStr;

@end

NS_ASSUME_NONNULL_END
