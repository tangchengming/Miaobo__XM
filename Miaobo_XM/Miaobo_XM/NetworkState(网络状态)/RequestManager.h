//
//  RequestManager.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/9/27.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLShareSingle.h"
#import "ResponseObject.h"
#import "XMHotHeaderResult.h"

typedef void (^ProgressBlock)(NSProgress *downloadProgress);
typedef void(^SucessBlock)(NSURLSessionDataTask *task, id responseObject,ResponseObject *result) ;

typedef void(^FailureBlock)(NSURLSessionDataTask *task, NSError *error) ;

@interface RequestManager : NSObject

//封装GTE请求

XLSingletonH(LiveTool)

/** 请求新晋主播数据 */
+ (void)GetWithNewURL:(NSInteger)page success:(void (^)(ResponseObject *result))success failure:(void (^)(NSError *error))failure;

/** 请求热门主播数据 */
+ (void)GetWithHotURL:(NSInteger)page success:(void (^)(ResponseObject *result))success failure:(void (^)(NSError *error))failure;

/** 请求热门头部信息 */
+ (void)GetWithSuccess:(void (^)(XMHotHeaderResult *result))success failure:(void (^)(NSError *error))failure;

/** 请求数据 */
+ (void)GetWithURL:(NSString *)url success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;


//封装POST请求
+ (void)httpRequestPOST:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure responseSerializer:(id)serializer toView:(UIView *)view;

@end
