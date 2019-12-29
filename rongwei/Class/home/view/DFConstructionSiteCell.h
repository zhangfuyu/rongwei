//
//  DFConstructionSiteCell.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFStageInfosSiteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFConstructionSiteCell : UITableViewCell

@property (nonatomic , strong) DFStageInfosSiteModel *model;

@property (nonatomic , strong) NSString *stage_name;

@end

NS_ASSUME_NONNULL_END
