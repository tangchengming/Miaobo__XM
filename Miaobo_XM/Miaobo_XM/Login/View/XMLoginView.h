//
//  XMLoginView.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/10/13.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <UIKit/UIKit.h>
//枚举 第三方登录
typedef NS_ENUM(NSInteger,XMType) {

    LoginTypeSina,
    LoginTypeQQ,
    LoginTypeWechat
};


@interface XMLoginView : UIView

//点击按钮
@property (nonatomic , copy) void(^selectedBlock)(XMType type);

@end
