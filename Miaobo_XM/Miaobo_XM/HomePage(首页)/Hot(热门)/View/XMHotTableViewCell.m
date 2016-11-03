//
//  XMHotTableViewCell.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMHotTableViewCell.h"
#import <ShareSDKUI/ShareSDKUI.h>
@implementation XMHotTableViewCell



+ (instancetype)tableViewCell{

    return [[[NSBundle mainBundle]loadNibNamed:@"XMHotTableViewCell" owner:nil options:nil]firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    
}

- (void)setHotModel:(XMHotModel *)hotModel{
    
    _hotModel = hotModel;
    
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.headImageView.image = [UIImage circleImage:image borderColor:[UIColor clearColor] borderWidth:1];
    }];
    
    self.nameLabel.text = hotModel.myname;
    
    //如果没有定位地址 给个默认地址
    if (!hotModel.gps.length) {
        
        hotModel.gps = @"喵星";
    }
    
    [self.locationBtn setTitle:hotModel.gps forState:UIControlStateNormal];
    
    [self.bigPicView sd_setImageWithURL:[NSURL URLWithString:hotModel.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
    
    self.startView.image = hotModel.starImage;
    self.startView.hidden = !hotModel.starlevel;
    
    //设置当前观众数量
    NSString *fans = [NSString stringWithFormat:@"%@人看",hotModel.allnum];
    NSRange range = [fans rangeOfString:[NSString stringWithFormat:@"%@",hotModel.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:fans];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:range];
    self.fansLabel.attributedText = attr;
    self.fansLabel.adjustsFontSizeToFitWidth = YES;
    
    self.roomid.text = [NSString stringWithFormat:@"房间号:%@",hotModel.roomid];
    
    self.signatures.text = hotModel.signatures;
    
    
}

//分享
- (IBAction)share:(UIButton *)sender {
    
    NSString *text = [NSString stringWithFormat:@"主播昵称:%@\n  房间号:%@\n    观看人数:%@\n    个性签名:%@",_hotModel.myname,_hotModel.roomid,_hotModel.allnum,_hotModel.signatures];
    UIImage *image = self.bigPicView.image;
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text images:image url:[NSURL URLWithString:@"http://www.baidu.com"] title:@"小明的喵播" type:SSDKContentTypeAuto];
    
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];
}



- (CGFloat)height{
    return self.bigPicView.height + self.bigPicView.y;
}

@end
