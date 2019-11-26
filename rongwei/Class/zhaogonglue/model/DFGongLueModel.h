//
//  DFGongLueModel.h
//  rongwei
//
//  Created by zhangfuyu on 2019/11/25.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFGongLueModel : JSONModel

@property (nonatomic , strong) NSString<Optional> *modelId;

@property (nonatomic , strong) NSString<Optional> *bbs_collect_num;

@property (nonatomic , strong) NSString<Optional> *bbs_com_num;

@property (nonatomic , strong) NSString<Optional> *bbs_like_num;

@property (nonatomic , strong) NSString<Optional> *bbs_pic;

@property (nonatomic , strong) NSString<Optional> *bbs_title;

@property (nonatomic , strong) NSString<Optional> *bbs_user_id;

@property (nonatomic , strong) NSString<Optional> *bbs_user_image;

@property (nonatomic , strong) NSString<Optional> *bbs_user_name;

@property (nonatomic , strong) NSString<Optional> *bbs_view;

@property (nonatomic , strong) NSDictionary<Optional> *modelclass;

@property (nonatomic , strong) NSString<Optional> *class_id;

@property (nonatomic , strong) NSString<Optional> *created_at;

@property (nonatomic , strong) NSString<Optional> *updated_at;

@property (nonatomic , strong) NSString<Optional> *bbs_content;

@property (nonatomic , strong) NSString<Optional> *sort;



@end

NS_ASSUME_NONNULL_END
