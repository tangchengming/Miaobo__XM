//
//  ALinNetworkTool.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/9/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger,NetworkStates) {
    NetworkStatesNone,  //无网络
    NetworkStates2G,    //2G
    NetworkStates3G,    //3G
    NetworkStates4G,    //4G
    NetworkStatesWIFI,  //WIFI
};

@interface ALinNetworkTool : AFHTTPSessionManager

//+ (instancetype)shareToll;

//判断网络类型
+ (NetworkStates)getNetworkStates;
@end
