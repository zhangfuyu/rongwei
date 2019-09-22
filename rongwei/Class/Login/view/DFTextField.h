//
//  DFTextField.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/22.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFTextField : UITextField

/**
 最大输入位数
 */
@property (nonatomic, assign) NSUInteger maxInputDigit;

/**
 结束编辑的位数
 */
@property (nonatomic, assign) NSUInteger endEditingDigit;

/**
 左边距
 */
@property (nonatomic, assign) CGFloat leftSpace;


/**
 右边距
 */
@property (nonatomic, assign) CGFloat rightSpace;

@end

NS_ASSUME_NONNULL_END
