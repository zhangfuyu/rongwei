//
//  DFWorkListTableViewCell.h
//  rongwei
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFDesignerWorkModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DFWorkListTableViewCell : UITableViewCell
@property (nonatomic , strong) DFDesignerWorkModel *model;
@end

NS_ASSUME_NONNULL_END
