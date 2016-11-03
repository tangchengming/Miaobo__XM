//
//  XMNewData.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMNewData : NSObject
/** 返回多少条主播信息 */
@property (nonatomic, strong) NSNumber *totalPage;
/** 主播信息列表 */
@property (nonatomic, strong) NSArray *list;
@end
