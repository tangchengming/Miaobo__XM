//
//  XMNewData.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMNewData.h"
#import "XMNewModel.h"
@implementation XMNewData

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"list":[XMNewModel class]};
}
@end
