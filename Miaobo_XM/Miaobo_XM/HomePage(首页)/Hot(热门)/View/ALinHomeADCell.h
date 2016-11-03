//
//  ALinHomeADCell.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/31.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRCarouselView.h"
#import "XMHotHeaderModel.h"
@interface ALinHomeADCell : UITableViewCell<XRCarouselViewDelegate>


/** 顶部AD数组 */
@property (nonatomic, strong) NSArray *headerModels;
/** 点击图片的block */
@property (nonatomic, copy) void (^imageClickBlock)(XMHotHeaderModel *headerModel);
@end
