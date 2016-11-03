//
//  XMCustomTitleView.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/20.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, Type) {
    HomeTypeHot, // 热门
    HomeTypeNew, // 最新
    HomeTypeAttention // 关注
};

@interface XMCustomTitleView : UIView

//下划线
@property(nonatomic,weak)UIView *underLine;

//选中了
@property(nonatomic,copy)void (^selectedBlock)(Type type);

//设置滑动选中的按钮
@property(nonatomic,assign)Type type;

//选中按钮
@property(nonatomic,weak)UIButton *selectedBtn;

@end
