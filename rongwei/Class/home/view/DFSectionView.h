//
//  DFSectionView.h
//  rongwei
//
//  Created by zhangfuyu on 2019/10/14.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFSectionView : UIView

@property (nonatomic , assign)BOOL isShowSubTitle;

@property (nonatomic , strong)NSString *titleText;

@property (nonatomic , strong)NSString *subText;

@property (nonatomic , strong)NSMutableArray *hotArry;

@end

NS_ASSUME_NONNULL_END
