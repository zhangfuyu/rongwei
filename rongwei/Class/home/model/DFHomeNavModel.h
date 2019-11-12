//
//  DFHomeNavModel.h
//  rongwei
//
//  Created by apple on 2019/11/12.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFHomeNavModel : JSONModel
@property (nonatomic , strong) NSString<Optional> *after_open;

@property (nonatomic , strong) NSString<Optional> *android_activity;

@property (nonatomic , strong) NSString<Optional> *custom;

@property (nonatomic , strong) NSString<Optional> *modelid;

@property (nonatomic , strong) NSString<Optional> *ios_activity;

@property (nonatomic , strong) NSString<Optional> *name;

@property (nonatomic , strong) NSString<Optional> *pic_url;

@property (nonatomic , strong) NSString<Optional> *sort;

@property (nonatomic , strong) NSString<Optional> *updated_at;

@property (nonatomic , strong) NSString<Optional> *url;

@end

NS_ASSUME_NONNULL_END
