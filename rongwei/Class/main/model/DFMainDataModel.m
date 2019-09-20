//
//  DFMainDataModel.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/20.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFMainDataModel.h"

@implementation DFMainDataModel

+ (NSMutableArray *)getDataSource
{
    
    NSMutableArray *dataArry = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *firstArry = @[@{
                               @"title":@"待确认",
                               @"iamgeName":@"daiqueren"
                               },
                           @{
                               @"title":@"待量房",
                               @"iamgeName":@"mianfeiliangfang"
                               },
                           @{
                               @"title":@"待付款",
                               @"iamgeName":@"fukuan"
                               },
                           @{
                               @"title":@"待评价",
                               @"iamgeName":@"pingjia"
                               }
                           ];
    
    NSArray *secondArry = @[@{
                                @"title":@"待确认",
                                @"iamgeName":@"daiqueren"
                                },
                            @{
                                @"title":@"待收货",
                                @"iamgeName":@"shouhuo1"
                                },
                            @{
                                @"title":@"待付款",
                                @"iamgeName":@"fukuan"
                                },
                            @{
                                @"title":@"退还/售后",
                                @"iamgeName":@"shouhou"
                                }
                            ];
    
    NSArray *threeArry = @[@{
                                @"title":@"待开工",
                                @"iamgeName":@"daiqueren"
                                },
                            @{
                                @"title":@"待完工",
                                @"iamgeName":@"yiwangong"
                                },
                            @{
                                @"title":@"待保单",
                                @"iamgeName":@"baodanfapiao"
                                },
                            @{
                                @"title":@"待评价",
                                @"iamgeName":@"pingjia"
                                }
                            ];
    
    NSArray *foreArry = @[@{
                               @"title":@"我的保修单",
                               @"iamgeName":@"baoxiu"
                               },
                           @{
                               @"title":@"我的设计图",
                               @"iamgeName":@"shejijishu"
                               },
                           @{
                               @"title":@"我的互动",
                               @"iamgeName":@"hudongxiaoxi"
                               },
                           @{
                               @"title":@"我的攻略",
                               @"iamgeName":@"xinshougonglve--"
                               }
                           ,
                           @{
                               @"title":@"工地直播",
                               @"iamgeName":@"zhiboke"
                               }
                           ,
                           @{
                               @"title":@"我的发票",
                               @"iamgeName":@"fapiao"
                               }
                           ];
    
    NSArray *fiveArry = @[@{
                              @"title":@"找设计",
                              @"iamgeName":@"zhaosheji"
                              },
                          @{
                              @"title":@"找施工",
                              @"iamgeName":@"zhaoshigong"
                              },
                          @{
                              @"title":@"要监理",
                              @"iamgeName":@"yaojianli"
                              },
                          @{
                              @"title":@"算报价",
                              @"iamgeName":@"suanbaojia"
                              }
                          ,
                          @{
                              @"title":@"成为设计师",
                              @"iamgeName":@"chengweishejishi"
                              }
                          ,
                          @{
                              @"title":@"招商入口",
                              @"iamgeName":@"zhaoshangjiameng"
                              }
                          ];
    
    NSArray *sixArry = @[@{
                               @"title":@"联系我们",
                               @"iamgeName":@"lianxiwomen"
                               },
                           @{
                               @"title":@"关于我们",
                               @"iamgeName":@"weibiaoti--"
                               },
                           @{
                               @"title":@"投诉建议",
                               @"iamgeName":@"tousujianyi"
                               }
                           ];
    
    [dataArry addObject:firstArry];
    [dataArry addObject:secondArry];
    [dataArry addObject:threeArry];
    [dataArry addObject:foreArry];
    [dataArry addObject:fiveArry];
    [dataArry addObject:sixArry];

    
    return dataArry;
    
    
}

+ (NSMutableArray *)getDataSourceForTitle
{
    
    

    
    NSArray *secondArry = @[@{
                                @"title":@"设计订单",
                                @"iamgeName":@"daiqueren"
                                },
                            @{
                                @"title":@"商城订单",
                                @"iamgeName":@"shouhuo1"
                                },
                            @{
                                @"title":@"施工订单",
                                @"iamgeName":@"fukuan"
                                },
                            @{
                                @"title":@"工具与服务",
                                @"iamgeName":@""
                                }
                            ,
                            @{
                                @"title":@"快接入口",
                                @"iamgeName":@""
                                },
                            @{
                                @"title":@"关于荣装",
                                @"iamgeName":@""
                                }
                            ];
    
    NSMutableArray *dataArry = [NSMutableArray arrayWithArray:secondArry];

    
    return dataArry;

}

@end
