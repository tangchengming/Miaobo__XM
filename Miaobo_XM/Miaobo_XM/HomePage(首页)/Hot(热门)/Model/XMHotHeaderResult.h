//
//  XMHotHeaderResult.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMHotHeaderResult : NSObject
/** 状态码 */
@property (nonatomic, copy) NSString *code;

/** 状态 */
@property (nonatomic, copy) NSString *msg;

/** 返回主播信息 */
@property (nonatomic, strong) NSArray *data;

@end
