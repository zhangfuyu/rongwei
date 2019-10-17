//
//  DFWaterFallLayout.h
//  rongwei
//
//  Created by apple on 2019/10/17.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DFWaterFallLayout;

@protocol  DFWaterFallLayoutDeleaget<NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(DFWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(DFWaterFallLayout *)waterFallLayout;


@end


@interface DFWaterFallLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<DFWaterFallLayoutDeleaget> fallDelegate;

/** 段头的size */
@property (nonatomic, assign) CGSize headerReferenceSize;

@end

NS_ASSUME_NONNULL_END
