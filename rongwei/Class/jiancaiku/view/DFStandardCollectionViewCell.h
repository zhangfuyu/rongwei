//
//  DFStandardCollectionViewCell.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/15.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFStandardCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *lab_standard;

@property (nonatomic, strong)DFChildModel *model;
@end

NS_ASSUME_NONNULL_END
