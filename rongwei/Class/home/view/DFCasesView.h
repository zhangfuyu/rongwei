//
//  DFCasesView.h
//  rongwei
//
//  Created by apple on 2019/9/26.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFCasesView : UIView

@property (nonatomic, copy) void (^clickTypeBlock)(NSString *clickTitle);


@property (nonatomic, strong)  NSMutableArray *titleArry;

@property (nonatomic, assign) NSInteger selectBtnTag;

@property (nonatomic, assign) BOOL canscroll;

@property (nonatomic, strong) NSString *workcount;

@end

NS_ASSUME_NONNULL_END
