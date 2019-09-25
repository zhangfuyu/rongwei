//
//  DFDesignerModel.h
//  rongwei
//
//  Created by apple on 2019/9/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFDesignerModel : JSONModel


/// 预约数量
@property (nonatomic , strong) NSString *appointment_num;


/// 用户头像
@property (nonatomic , strong) NSString *avatar;


/// 城市Id
@property (nonatomic , strong) NSString *city_id;

@property (nonatomic , strong) NSString *modelId;


/// 最大收费
@property (nonatomic , strong) NSString *max_money;

/// 最小收费
@property (nonatomic , strong) NSString *min_money;


/// 用户名
@property (nonatomic , strong) NSString *name;


/// 签单数量
@property (nonatomic , strong) NSString *order_num;


/// 擅长风格 14,20,7
@property (nonatomic , strong) NSString *styles;


/// 作量数量
@property (nonatomic , strong) NSString *works_num;


/// 从业年数
@property (nonatomic , strong) NSString *years;


/// 擅长风格
@property (nonatomic , strong) NSArray *styles_name;



@end

NS_ASSUME_NONNULL_END
