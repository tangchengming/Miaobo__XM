//
//  XMDealData.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMDealData.h"
#define XMData [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"allModel.pist"]
@interface XMDealData (){
    
    NSMutableArray *_allModels;
}

@end

@implementation XMDealData

XLSingletonM(DealData)

- (NSMutableArray *)allModels{

    if (!_allModels) {
        
        _allModels = [NSKeyedUnarchiver unarchiveObjectWithFile:XMData];
        
        if (!_allModels) {
            
            _allModels = [NSMutableArray array];
        }
    }
    
    return _allModels;
}

//保存数据

- (void)saveData:(XMHotModel *)hotModel{
    
    [self.allModels removeObject:hotModel];
    
    [self.allModels insertObject:hotModel atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:self.allModels toFile:XMData];
}

//删除数据
- (void)unsaveData:(XMHotModel *)hotModel{
    
    [[XMDealData shareDealData].allModels enumerateObjectsUsingBlock:^(XMHotModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([hotModel.flv isEqualToString:obj.flv]) {
            
            [self.allModels removeObject:obj];
        }
    }];
    
    [NSKeyedArchiver archiveRootObject:self.allModels toFile:XMData];

}


@end
