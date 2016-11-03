//
//  XMDealData.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHotModel.h"
#import "XLShareSingle.h"
@interface XMDealData : NSObject

//保存数据
- (void)saveData:(XMHotModel *)hotModel;
//删除数据
- (void)unsaveData:(XMHotModel *)hotModel;
@end
