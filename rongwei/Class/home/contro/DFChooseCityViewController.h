//
//  DFChooseCityViewController.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/29.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DFChooseCityViewControllerDelegate <NSObject>
@optional

- (void)selectChooseprovinceId:(NSString *)province_id city_id:(NSString *)cityID area_id:(NSString *)areaId;

@end


@interface DFChooseCityViewController : DFBaseViewController

@property (nonatomic , weak)id<DFChooseCityViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
