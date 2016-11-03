//
//  ALinNetworkTool.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/9/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "ALinNetworkTool.h"

@implementation ALinNetworkTool
//判断网络类型
+ (NetworkStates)getNetworkStates{
    
    NSArray *subviews = [[[[UIApplication sharedApplication]valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    //保存网络状态
    NetworkStates states = NetworkStatesNone;
    
    for (id child in subviews) {
        
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNeworkType"] intValue];
            
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates3G;
                    break;
                case 4:
                    states = NetworkStates4G;
                    break;
                case 5:
                {
                    states = NetworkStatesWIFI;
                }
                default:
                    break;
            }
        }
    }
    
    return states;
}

@end
