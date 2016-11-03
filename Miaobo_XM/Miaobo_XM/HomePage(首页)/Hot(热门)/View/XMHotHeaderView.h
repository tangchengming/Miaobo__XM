//
//  XMHotHeaderView.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHotHeaderModel.h"
#import "XRCarouselView.h"

@interface XMHotHeaderView : UIView

//顶部AD数组
@property (nonatomic,strong)NSArray *headerModels;

//点击图片block
@property (nonatomic,copy)void(^imageClickBlock)(XMHotHeaderModel *headerModel);
@end
