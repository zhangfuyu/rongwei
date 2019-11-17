//
//  DFGetNetData.m
//  rongwei
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGetNetData.h"
#import "DFHomeNavModel.h"

@implementation DFGetNetData
+ (NSMutableArray *)getadvertising
{
    NSMutableArray *arry = [NSMutableArray arrayWithCapacity:0];
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:HomeAds withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSArray *hot = response[@"data"][@"APP-热门攻略广告位"];
            for (NSInteger index = 0; index < hot.count; index ++) {
                NSDictionary *dic = hot[index];
                DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                [[DFUserModelTool shareInstance].hotArry addObject:model];
            }
            NSArray *banaer = response[@"data"][@"APP-首页轮播图"];
            for (NSInteger index = 0; index < banaer.count; index ++) {
                 NSDictionary *dic = hot[index];
                 DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                 [[DFUserModelTool shareInstance].banaerArry addObject:model];
            }
            
            NSArray *navdown = response[@"data"][@"APP-图标导航下方广告"];
            for (NSInteger index = 0; index < navdown.count; index ++) {
                 NSDictionary *dic = navdown[index];
                 DFHomeNavModel *model = [[DFHomeNavModel alloc]initWithDictionary:dic error:nil];
                 [[DFUserModelTool shareInstance].banaerArry addObject:model];
            }
            
        }
    }];
    
    return arry;
    
}
@end
