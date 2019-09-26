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
@property (nonatomic , strong) NSString<Optional> *appointment_num;


/// 用户头像
@property (nonatomic , strong) NSString<Optional> *avatar;


/// 城市Id
@property (nonatomic , strong) NSString<Optional> *city_id;

@property (nonatomic , strong) NSString<Optional> *modelId;


/// 最大收费
@property (nonatomic , strong) NSString<Optional> *max_money;

/// 最小收费
@property (nonatomic , strong) NSString<Optional> *min_money;


/// 用户名
@property (nonatomic , strong) NSString<Optional> *name;


/// 签单数量
@property (nonatomic , strong) NSString<Optional> *order_num;


/// 擅长风格 14,20,7
@property (nonatomic , strong) NSString<Optional> *styles;


/// 作量数量
@property (nonatomic , strong) NSString<Optional> *works_num;


/// 从业年数
@property (nonatomic , strong) NSString<Optional> *years;


/// 擅长风格
@property (nonatomic , strong) NSArray<Optional> *styles_name;



@property (nonatomic , strong) NSString<Optional> *area_id;

@property (nonatomic , strong) NSString<Optional> *province_id;

@property (nonatomic , strong) NSString<Optional> *comment_num;

@property (nonatomic , strong) NSString<Optional> *created_at;

@property (nonatomic , strong) NSString<Optional> *is_hide;

@property (nonatomic , strong) NSString<Optional> *is_rec;

@property (nonatomic , strong) NSString<Optional> *is_top;

@property (nonatomic , strong) NSString<Optional> *score;

@property (nonatomic , strong) NSString<Optional> *sort;

@property (nonatomic , strong) NSString<Optional> *updated_at;
@end

NS_ASSUME_NONNULL_END
