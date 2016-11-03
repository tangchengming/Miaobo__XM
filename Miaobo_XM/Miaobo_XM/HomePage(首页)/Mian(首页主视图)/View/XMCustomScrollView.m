//
//  XMCustomScrollView.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/20.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMCustomScrollView.h"
#import "XMHotViewController.h"
#import "XMNewViewController.h"
#import "XMAttentionViewController.h"
@interface XMCustomScrollView ()


@property (nonatomic , strong)XMAttentionViewController *attView;
@end
@implementation XMCustomScrollView
//滚动视图
- (void) setupBasic{

    //去掉滚动条
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    //去掉弹簧效果
    self.bounces = YES;
    
    //设置自动分页
    self.pagingEnabled = YES;
    
    //每页尺寸大小
    self.frame = kScreenFrame;
    
    //总宽度
    self.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    
    //创建：热门～最新～关注  视图
    XMHotViewController *hot = [[XMHotViewController alloc]init];
    XMNewViewController *new = [[XMNewViewController alloc]init];
    //self.attView = [[XMAttentionViewController alloc]init];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    self.attView = [[XMAttentionViewController alloc]initWithCollectionViewLayout:flow];
    
    [self addSubview:hot.view];
    [self addSubview:new.view];
    [self addSubview:self.attView.view];
    
    hot.view.y = 0;
    hot.view.x = 0;
    new.view.x = kScreenWidth;
    self.attView.view.x =kScreenWidth * 2;
    
    [self.vc addChildViewController:hot];
    [self.vc addChildViewController:new];
    [self.vc addChildViewController:self.attView];
    
}

- (void)setContenOffsetX:(NSInteger)contenOffsetX{
    
    _contenOffsetX = contenOffsetX;
    
    //如果x坐标大于屏幕宽度就重新加载关注页面，便于关注数据的刷新
    if (contenOffsetX > kScreenWidth) {
        
        [self.attView.collectionView reloadData];
    }
}

- (void)setVc:(UIViewController *)vc{
    
    _vc = vc;
    
    [self setupBasic];

}

@end
