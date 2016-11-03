//
//  XMHotModel.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMHotModel.h"

@implementation XMHotModel

MJCodingImplementation

- (UIImage *)starImage{

    if (self.starlevel) {
        
        return [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19",self.starlevel]];
    }
    
    return nil;
}

@end
