//
//  XMTabBarViewController.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/20.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMTabBarViewController.h"
#import "XMHomeViewController.h"
#import "XMPlayLiveViewController.h"
#import "XMAttentionViewController.h"
#import "XMNavigationController.h"

@interface XMTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation XMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setupBasic];
}


- (void)setupBasic{

    //首页
    [self addChildViewController:[[XMHomeViewController alloc]init] notmalimageNamed:@"toolbar_home" selectedImage:@"toolbar_home_sel" title:@"首页"];
    
    //直播
    [self addChildViewController:[[XMPlayLiveViewController alloc]init] notmalimageNamed:@"toolbar_live" selectedImage:nil title:@"直播"];
    
    //个人中心
    [self addChildViewController:[[XMAttentionViewController alloc]init] notmalimageNamed:@"toolbar_me" selectedImage:@"toolbar_me_sel" title:@"个人中心"];
}

//UITabBarButton按钮-图标的封装
- (void) addChildViewController:(UIViewController *)childController notmalimageNamed:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title{

    XMNavigationController *nav = [[XMNavigationController alloc]initWithRootViewController:childController];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childController.title = title;
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(214, 41, 117)} forState:UIControlStateNormal];
    
    [self addChildViewController:nav];
}

#pragma mark 代理方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    if ([viewController.tabBarItem.image isEqual:[UIImage imageNamed:@"toolbar_live"]]) {
        
        [self presentViewController:[[XMPlayLiveViewController alloc]init] animated:YES completion:nil];
        
        return NO;
    }

    return YES;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
