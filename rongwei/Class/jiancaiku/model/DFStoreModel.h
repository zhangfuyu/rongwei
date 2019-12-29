//
//  DFStoreModel.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/9.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFStoreModel : JSONModel

@property (nonatomic , strong) NSString<Optional> *address;

@property (nonatomic , strong) NSString<Optional> *brand;

@property (nonatomic , strong) NSString<Optional> *area_id;

@property (nonatomic , strong) NSString<Optional> *brief;

@property (nonatomic , strong) NSArray<Optional> *carousel_image;

@property (nonatomic , strong) NSString<Optional> *city_id;

@property (nonatomic , strong) NSString<Optional> *company_user_id;

@property (nonatomic , strong) NSString<Optional> *description_score;

@property (nonatomic , strong) NSString<Optional> *logistics_score;

@property (nonatomic , strong) NSString<Optional> *logo_image;

@property (nonatomic , strong) NSString<Optional> *province_id;

@property (nonatomic , strong) NSString<Optional> *service_score;

@property (nonatomic , strong) NSString<Optional> *shop_address;

@property (nonatomic , strong) NSString<Optional> *shop_category;

@property (nonatomic , strong) NSString<Optional> *shop_id;

@property (nonatomic , strong) NSString<Optional> *shop_name;

@property (nonatomic , strong) NSString<Optional> *created_at;

@property (nonatomic , strong) NSString<Optional> *follow_num;




@end

NS_ASSUME_NONNULL_END
