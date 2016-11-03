//
//  ResponseObject.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/9/28.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseObject : NSObject
/** 状态码 */
@property (nonatomic,strong)NSString *code;
/** 状态 */
@property (nonatomic,strong)NSString *msg;
/** 返回主播信息 */
@property (nonatomic,strong)NSDictionary *data;

//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
