//
//  XMHotHeaderResult.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMHotHeaderResult.h"
#import "XMHotHeaderModel.h"
@implementation XMHotHeaderResult
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [XMHotHeaderModel class]};
}
@end
