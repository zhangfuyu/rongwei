//
//  DFGoodsDetailModel.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/13.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFStoreModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFGoodsDetailModel : JSONModel

@property (nonatomic , strong) NSString<Optional> *spu_id;

@property (nonatomic , strong) NSString<Optional> *shop_id;

@property (nonatomic , strong) NSString<Optional> *category_id;

@property (nonatomic , strong) NSString<Optional> *spu_no;

@property (nonatomic , strong) NSString<Optional> *goods_name;

@property (nonatomic , strong) NSString<Optional> *goods_thumb;

@property (nonatomic , strong) NSString<Optional> *low_price;

@property (nonatomic , strong) NSString<Optional> *line_price;

@property (nonatomic , strong) NSString<Optional> *brand_id;

@property (nonatomic , strong) NSString<Optional> *spec_type;

@property (nonatomic , strong) NSString<Optional> *sales_initial;

@property (nonatomic , strong) NSString<Optional> *sales_actual;

@property (nonatomic , strong) NSString<Optional> *delivery_id;

@property (nonatomic , strong) NSString<Optional> *created_at;

@property (nonatomic , strong) NSArray<Optional> *sku;

@property (nonatomic , strong) NSArray<Optional> *spec;

@property (nonatomic , strong) NSDictionary<Optional> *infos;

@property (nonatomic , strong) DFStoreModel<Optional> *shopDetailModel;

@end

NS_ASSUME_NONNULL_END
