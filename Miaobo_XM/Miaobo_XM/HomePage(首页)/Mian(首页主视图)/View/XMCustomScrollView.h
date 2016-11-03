//
//  XMCustomScrollView.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/20.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XMCustomScrollView : UIScrollView

@property (nonatomic ,strong) UIViewController *vc;

//偏移x坐标
@property (nonatomic ,assign) NSInteger contenOffsetX;


@end
