//
//  DFGetNetData.m
//  rongwei
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFGetNetData.h"

@implementation DFGetNetData
+ (NSMutableArray *)getadvertising
{
    NSMutableArray *arry = [NSMutableArray arrayWithCapacity:0];
    [[DFNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:HomeAds withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
        }
    }];
    
    return arry;
    
}
@end
