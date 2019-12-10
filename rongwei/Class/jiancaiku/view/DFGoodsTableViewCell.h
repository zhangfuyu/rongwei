//
//  DFGoodsTableViewCell.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/10.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFGoodsTableViewCell : UITableViewCell

@property (nonatomic , assign) NSInteger indexPath;
@property (nonatomic , strong) NSMutableArray *goodArry;

@end

NS_ASSUME_NONNULL_END
