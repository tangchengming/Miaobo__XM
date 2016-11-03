//
//  XMHotTableViewCell.h
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHotModel.h"
@interface XMHotTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bigPicView;//直播照片
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;//头像
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;//定位城市
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//主播名
@property (weak, nonatomic) IBOutlet UIImageView *startView;//星级
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;//观众
@property (weak, nonatomic) IBOutlet UILabel *roomid;//房间号
@property (weak, nonatomic) IBOutlet UILabel *signatures;//签名

@property (strong, nonatomic) XMHotModel *hotModel;
@property (strong, nonatomic) NSArray *allModels;
@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) UIViewController *parentVC;
+(instancetype)tableViewCell;
@end
