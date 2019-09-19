//
//  DFNetworkTool.h
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFApi.h"


NS_ASSUME_NONNULL_BEGIN



typedef void(^completionBlock)(BOOL isSuccess, NSString * _Nullable msg, id _Nullable response);

typedef enum : NSUInteger {
    GHRequestMethod_GET,
    GHRequestMethod_POST,
    GHRequestMethod_PUT,
    GHRequestMethod_DELETE,
} GHRequestMethod;


typedef enum : NSUInteger {
    GHLoadingType_ShowLoading,
    GHLoadingType_HideLoading,
} GHLoadingType;

typedef enum : NSUInteger {
    GHContentType_Formdata,
    GHContentType_JSON,
} GHContentType;

@interface DFNetworkTool : NSObject


+ (instancetype)shareInstance;

/**
 普通网络请求
 
 @param method 请求方式 GHRequestMethod_GET/GHRequestMethod_POST/GHRequestMethod_PUT/GHRequestMethod_DELETE
 @param url <#url description#>
 @param parameter <#parameter description#>
 @param loadingType 是否需要请求结果 GHLoadingType_ShowLoading/GHLoadingType_HideLoading
 @param shouldHaveToken 是否需要加入 Token
 @param contentType 请求格式 GHContentType_Formdata/GHContentType_JSON
 @param completionBlock <#completionBlock description#>
 */
- (void)requestWithMethod:(GHRequestMethod)method withUrl:(NSString *)url withParameter:(NSDictionary * __nullable)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType  completionBlock:(completionBlock)completionBlock;


@end

NS_ASSUME_NONNULL_END
