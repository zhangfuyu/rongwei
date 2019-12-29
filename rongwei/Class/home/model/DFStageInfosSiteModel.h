//
//  DFStageInfosSiteModel.h
//  rongwei
//
//  Created by zhangfuyu on 2019/12/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFStageInfosSiteModel : JSONModel

@property (nonatomic , strong) NSString<Optional> *modelid;

@property (nonatomic , strong) NSString<Optional> *note;

@property (nonatomic , strong) NSArray<Optional> *pic_json;

@property (nonatomic , strong) NSString<Optional> *site_id;

@property (nonatomic , strong) NSString<Optional> *stage_id;

@property (nonatomic , strong) NSString<Optional> *stage_name;

@property (nonatomic , strong) NSString<Optional> *updated_at;


@end

NS_ASSUME_NONNULL_END
