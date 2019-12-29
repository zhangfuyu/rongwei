//
//  DFCategoryModel.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/11.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFCategoryModel : JSONModel

@property (nonatomic , strong) NSString<Optional> *category_name;

@property (nonatomic , strong) NSString<Optional> *modelid;

@property (nonatomic , strong) NSString<Optional> *img_url;

@property (nonatomic , strong) NSString<Optional> *is_rec;

@property (nonatomic , strong) NSString<Optional> *p_id;


@end

NS_ASSUME_NONNULL_END
