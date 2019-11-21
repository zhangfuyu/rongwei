//
//  DFCompanyModel.h
//  rongwei
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFCompanyModel : JSONModel
@property (nonatomic , strong) NSString<Optional> *address;

@property (nonatomic , strong) NSString<Optional> *area_id;

@property (nonatomic , strong) NSString<Optional> *avatar;

@property (nonatomic , strong) NSString<Optional> *brief;

@property (nonatomic , strong) NSString<Optional> *business_license_pic;

@property (nonatomic , strong) NSString<Optional> *city_id;

@property (nonatomic , strong) NSString<Optional> *comment_num;

@property (nonatomic , strong) NSString<Optional> *modelid;

@property (nonatomic , strong) NSString<Optional> *lat;

@property (nonatomic , strong) NSString<Optional> *lng;

@property (nonatomic , strong) NSString<Optional> *name;

@property (nonatomic , strong) NSString<Optional> *phone;

@property (nonatomic , strong) NSString<Optional> *province_id;

@property (nonatomic , strong) NSString<Optional> *scale;

@property (nonatomic , strong) NSString<Optional> *shapes;

@property (nonatomic , strong) NSString<Optional> *site_nums;

@property (nonatomic , strong) NSString<Optional> *sort;

@end

NS_ASSUME_NONNULL_END
