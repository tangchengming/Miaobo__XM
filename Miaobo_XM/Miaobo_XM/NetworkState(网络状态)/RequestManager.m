//
//  RequestManager.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/9/27.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

XLSingletonM(LiveTool)
/** 请求热门主播数据 */
+ (void)GetWithHotURL:(NSInteger)page success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.requestSerializer.HTTPShouldHandleCookies = NO;
    manager.requestSerializer.HTTPShouldUsePipelining = YES;
    [manager.operationQueue cancelAllOperations];
    //
    //    request.HTTPShouldHandleCookies = NO;
    //
    //    request.HTTPShouldUsePipelining = YES;
    
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [manager GET:[NSString stringWithFormat:Request_Method_HotAnchor, page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ResponseObject *result = [ResponseObject mj_objectWithKeyValues:responseObject];
        
        success(result);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}
/** 请求新晋主播数据 */
+ (void)GetWithNewURL:(NSInteger)page success:(void (^)(ResponseObject *))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [manager GET:[NSString stringWithFormat:Request_Method_NewAnchor, page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ResponseObject *result = [ResponseObject mj_objectWithKeyValues:responseObject];
        
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}
/** 请求热门头部信息 */
+ (void)GetWithSuccess:(void (^)(XMHotHeaderResult *))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [manager GET:Request_Method_ScrollView parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        XMHotHeaderResult *result = [XMHotHeaderResult mj_objectWithKeyValues:responseObject];
        
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}
/** 请求数据 */
+ (void)GetWithURL:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}


+ (void)httpRequestPOST:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure responseSerializer:(id)serializer toView:(UIView *)view{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    
    //设置超时时间
    sessionManager.requestSerializer.timeoutInterval = 5.f;
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    //请求地址 拼接
    string = [NSString stringWithFormat:@"%@%@",K_IP,string];
    
    [sessionManager POST:string parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress!= nil) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:view];
    
        
        ResponseObject *result = [responseObject mj_objectWithKeyValues:responseObject];
        
        if ([result.code integerValue] !=0 ) {
            [MBProgressHUD showMessage:result.msg toView:view afterDelty:1.0];
            return ;
        }
        sucess(task,responseObject,result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:view];
        [MBProgressHUD showMessage:@"请求失败" toView:view afterDelty:1.0];
        failure(task,error);
    }];

}

@end
