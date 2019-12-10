//
//  DFDesignerWorkModel.h
//  rongwei
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFDesignerWorkModel : JSONModel

@property (nonatomic , strong) NSString<Optional> *content;

@property (nonatomic , strong) NSString<Optional> *created_at;

@property (nonatomic , strong) NSString<Optional> *designer_id;

@property (nonatomic , strong) NSString<Optional> *designer_name;


@property (nonatomic , strong) NSString<Optional> *hits;

@property (nonatomic , strong) NSString<Optional> *modelid;

@property (nonatomic , strong) NSString<Optional> *img;

@property (nonatomic , strong) NSString<Optional> *img_num;

@property (nonatomic , strong) NSString<Optional> *is_hide;

@property (nonatomic , strong) NSString<Optional> *is_rec;

@property (nonatomic , strong) NSString<Optional> *is_top;

@property (nonatomic , strong) NSString<Optional> *mianji;

@property (nonatomic , strong) NSString<Optional> *quarter_id;

@property (nonatomic , strong) NSString<Optional> *quarter_name;


@property (nonatomic , strong) NSDictionary<Optional> *shape;

@property (nonatomic , strong) NSString<Optional> *shape_id;

@property (nonatomic , strong) NSString<Optional> *sort;

@property (nonatomic , strong) NSDictionary<Optional> *style;

@property (nonatomic , strong) NSString<Optional> *style_id;


@property (nonatomic , strong) NSString<Optional> *title;

@property (nonatomic , strong) NSString<Optional> *updated_at;

@property (nonatomic , strong) NSString<Optional> *zaojia;

@property (nonatomic , strong) NSArray<Optional> *work_images;

@property (nonatomic , strong) NSString<Optional> *coll_nums;

@property (nonatomic , strong) NSString<Optional> *designer_image;
@end

NS_ASSUME_NONNULL_END
