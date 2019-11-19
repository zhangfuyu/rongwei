//
//  DFCommentModel.h
//  rongwei
//
//  Created by apple on 2019/11/18.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFCommentModel : JSONModel
@property (nonatomic , strong) NSString<Optional> *content;

@property (nonatomic , strong) NSString<Optional> *created_at;

@property (nonatomic , strong) NSString<Optional> *designer_id;

@property (nonatomic , strong) NSString<Optional> *modelid;

@property (nonatomic , strong) NSString<Optional> *order_id;

@property (nonatomic , strong) NSString<Optional> *score;

@property (nonatomic , strong) NSString<Optional> *user_id;

@property (nonatomic , strong) NSString<Optional> *user_name;

@property (nonatomic , strong) NSString<Optional> *contentHeight;


@end

NS_ASSUME_NONNULL_END
