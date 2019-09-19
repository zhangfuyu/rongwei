//
//  DFNetworkTool.m
//  rongwei
//
//  Created by zhangfuyu on 2019/9/19.
//  Copyright © 2019 zhangfuyu. All rights reserved.
//

#import "DFNetworkTool.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <AFNetworkActivityIndicatorManager.h>


// 开发环境

static const NSString *ipAddress = @"http://apidev.zsu1.com";
static const NSString *htmlAddress = @"http://apidev.zsu1.com/";



@interface DFNetworkTool ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, copy) completionBlock uploadBlock;

@property (nonatomic, assign) BOOL isStop;

/**
 时间戳
 */
@property (nonatomic, strong) NSString *timeStamp;


@end

@implementation DFNetworkTool


+ (instancetype)shareInstance {
    
    static DFNetworkTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[DFNetworkTool alloc] init];
        [_tool setupSessionManage];
    });
    return _tool;
    
    
}
/**
 设置请求基本信息
 */
- (void)setupSessionManage {
    
    self.isStop = false;
    
    self.sessionManager = [AFHTTPSessionManager manager];
    self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.sessionManager.requestSerializer.timeoutInterval = 15;
    
    self.sessionManager.operationQueue.maxConcurrentOperationCount = 1;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
}


- (void)requestWithMethod:(GHRequestMethod)method withUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType completionBlock:(completionBlock)completionBlock {
    
    NSString *realUrl;
    
    if ([url hasPrefix:@"http"]) {
        realUrl = url;
    } else {
        realUrl = [NSString stringWithFormat:@"%@%@", ipAddress, url];
    }
    
    if (contentType == GHContentType_JSON) {
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    } else if (contentType == GHContentType_Formdata) {
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self.sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    
    if (shouldHaveToken == true && [DFUserModelTool shareInstance].isLogin == true) {
        NSLog(@"%@", [DFUserModelTool shareInstance].token);
        [self.sessionManager.requestSerializer setValue:ISNIL([DFUserModelTool shareInstance].token) forHTTPHeaderField:@"Authorization"];
    }
    
    [self.sessionManager.requestSerializer setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
    self.sessionManager.requestSerializer.timeoutInterval = 20;
    
    NSLog(@"---------------duoshaoge");
    
    if (method == GHRequestMethod_GET) {
        
        [self requestGETWithUrl:realUrl withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
        
    } else if (method == GHRequestMethod_POST) {
        
        [self requestPOSTWithUrl:realUrl withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
        
    }
//    else if (method == GHRequestMethod_PUT) {
//
//        [self requestPUTWithUrl:realUrl withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
//
//    } else if (method == GHRequestMethod_DELETE) {
//
//        [self requestDELETEWithUrl:realUrl withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
//
//    }
    
}

- (void)requestGETWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType  completionBlock:(completionBlock)completionBlock {
    
    [self.sessionManager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        id jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
            
            if (jsonDic) {
                [self requestSuccessWithUrl:url withResponseObject:jsonDic completionBlock:completionBlock];
            } else {
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                
                if (str.length) {
                    [self requestSuccessWithUrl:url withResponseObject:ISNIL(str) completionBlock:completionBlock];
                } else {
                    [self requestSuccessWithUrl:url withResponseObject:nil completionBlock:completionBlock];
                }
                
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestFailureWithMethod:GHRequestMethod_GET withUrl:url withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType withError:error withTask:task withCompletionBlock:completionBlock];
        
    }];
    
}

- (void)requestPOSTWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType  completionBlock:(completionBlock)completionBlock {
    
    [self.sessionManager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
            [self requestSuccessWithUrl:url withResponseObject:jsonDic completionBlock:completionBlock];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestFailureWithMethod:GHRequestMethod_POST withUrl:url withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType withError:error withTask:task withCompletionBlock:completionBlock];
        
    }];
    
}
/**
 连接服务器成功
 
 @param url <#url description#>
 @param responseObject <#responseObject description#>
 */
- (void)requestSuccessWithUrl:(NSString *)url withResponseObject:(id)responseObject  completionBlock:(completionBlock)completionBlock{
    
    completionBlock(true, @"成功" , responseObject);
    
}
//
/**
 连接服务器失败
 
 @param url <#url description#>
 @param error <#error description#>
 */
- (void)requestFailureWithMethod:(GHRequestMethod)method withUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)type withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType withError:(NSError *)error withTask:(NSURLSessionDataTask *)task withCompletionBlock:(completionBlock)completionBlock {
    
    // 不需要弹出错误提示
    if (type == GHLoadingType_HideLoading) {
        
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        completionBlock(false, [NSString stringWithFormat:@"%ld - %@", ((NSHTTPURLResponse *)task.response).statusCode, ISNIL(str)], nil);
        NSLog(@"%@---------%@", url, str);
        
        return;
    }
    
    
    completionBlock(false, [NSString stringWithFormat:@"%ld", ((NSHTTPURLResponse *)task.response).statusCode], nil);
    
    
    if (((NSHTTPURLResponse *)task.response).statusCode == 401) {
        
       
        
    } else if (((NSHTTPURLResponse *)task.response).statusCode == 403) {
        
        
       
        
    } else if (((NSHTTPURLResponse *)task.response).statusCode == 502) {
        
        self.isStop = false;
        
        [SVProgressHUD showErrorWithStatus:@"服务不可用,请稍候重试"];
        
        return;
        
    } else if (((NSHTTPURLResponse *)task.response).statusCode == 503) {
        
       
        
    }
    
    self.isStop = false;
    
    NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    if (data) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (str.length) {
            
           
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"请检查您的网络设置"];
            NSLog(@"================%@=================",url);
            
        }
        
    } else {
        
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络设置"];
        NSLog(@"================%@=================",url);
        
    }
    
    
    
    
}

@end