//
//  DFGongLueCommentModel.h
//  rongwei
//
//  Created by zhangfuyu on 2019/11/28.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFGongLueCommentModel : JSONModel

@property (nonatomic , strong) NSString<Optional> *modelId;

@property (nonatomic , strong) NSString<Optional> *bbs_id;

@property (nonatomic , strong) NSString<Optional> *com_user_id;

@property (nonatomic , strong) NSString<Optional> *comment_user_name;

@property (nonatomic , strong) NSString<Optional> *com_content;

@property (nonatomic , strong) NSString<Optional> *com_like_num;

@property (nonatomic , strong) NSString<Optional> *created_at;

@property (nonatomic , strong) NSString<Optional> *contentHeight;



@end

NS_ASSUME_NONNULL_END
