//
//  XMLoginViewController.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/10/13.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMLoginViewController.h"
#import "XMLoginView.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "XMTabBarViewController.h"
@interface XMLoginViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) IJKFFMoviePlayerController *player;

//封面图片
@property (nonatomic,weak) UIImageView *coverView;

//第三方登录
@property (nonatomic,weak) XMLoginView *thirdView;

//快速登录按钮
@property (nonatomic,weak) UIButton *loginBtn;



@end

@implementation XMLoginViewController

//快速登录按钮
- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        
        UIButton *loginBtn = [[UIButton alloc]init];
        
        loginBtn.backgroundColor = [UIColor clearColor];
        
        loginBtn.titleColor = RGBCOLOR(214, 41, 117);
        
        loginBtn.title = @"快速登录";
        
        loginBtn.layer.borderWidth = 1;
        
        loginBtn.layer.borderColor = RGBCOLOR(214, 41, 117).CGColor;
        
        loginBtn.highlightedTitleColor = [UIColor redColor];
        
        [loginBtn addTarget:self action:@selector(loginClick)];
        
        [self.view addSubview:loginBtn];
        
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@40);
            
            make.right.equalTo(@-40);
            
            make.centerX.mas_equalTo(kScreenWidth * 0.5);
            
            make.height.equalTo(@40);
            
            make.bottom.equalTo(self.view).offset(-60);
        }];
        
        _loginBtn = loginBtn;
    }
    
    return _loginBtn;
}


- (void) loginClick{

    [MBProgressHUD showMessage:@"登录中..."];
    
    [self jump];

}


- (XMLoginView *)thirdView{


    if (_thirdView == nil) {
        
        XMLoginView *thirdView = [[XMLoginView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        
        __weak typeof(self) weakSelf = self;
        
        [thirdView setSelectedBlock:^(XMType type) {
            
            weakSelf.coverView.hidden = YES;
            
            [self.coverView removeFromSuperview];
            
            weakSelf.coverView = nil;
            
            switch (type) {
                case LoginTypeSina:
                    
                    [weakSelf weibo];
                    
                    break;
                    
                    
                case LoginTypeQQ:
                    
                    [weakSelf QQ];
                    
                    break;
                    
                    
                case LoginTypeWechat:
                    
                    [weakSelf Wechat];
                    
                    break;
                    
                    
                default:
                    break;
            }
        }];
        
        [self.view addSubview:thirdView];
        
        thirdView.y = self.view.height - 40 - 60 - 60 - 30;
        
        _thirdView = thirdView;
    }
    
    return _thirdView;
}



//第三方登录实现

- (void)QQ{
    
    __weak typeof(self) weakSelf = self;
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        
        //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
        //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
        associateHandler (user.uid,user,user);
        
        NSLog(@"dd%@",user.rawData);
        
        NSLog(@"dd%@",user.credential);
        
        [MBProgressHUD showSuccess:@"登录成功"];
        
        [weakSelf jump];
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            
            
            
        }
    } ];

}

- (void)Wechat{
    __weak typeof(self) weakSelf = self;
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        
        associateHandler (user.uid,user,user);
        
        NSLog(@"dd%@",user.rawData);
        
        NSLog(@"dd%@",user.credential);
        
        [MBProgressHUD showSuccess:@"登录成功"];
        
        [weakSelf jump];
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        
        if (state == SSDKResponseStateSuccess) {
            
            
        }
    }];

}


- (void)weibo{
    
    __weak typeof(self) weakSelf = self;
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        
        associateHandler (user.uid,user,user);
        
        NSLog(@"dd%@",user.rawData);
        
        NSLog(@"dd%@",user.credential);
        
        [MBProgressHUD showSuccess:@"登录成功"];
        
        [weakSelf jump];
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        
        
        
    }];

}

//登录成功后跳转

- (void)jump{

    XMTabBarViewController *tab = [[XMTabBarViewController alloc]init];
    
    __weak typeof(self) weakSelf = self;
    
    //一秒后跳转
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showSuccess:@"登录成功"];
        
        [self presentViewController:tab animated:YES completion:^{
            
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            
            [weakSelf.player pause];
            
            [weakSelf.player stop];
            
            [weakSelf.player shutdown];
            
            [weakSelf.player.view removeFromSuperview];
            
            weakSelf.player = nil;
            
            [weakSelf.thirdView removeFromSuperview];
            
            weakSelf.thirdView = nil;
        }];
    });
}




//背景视频播放
- (IJKFFMoviePlayerController *)player{

    if (_player == nil) {
        
        NSString *path = arc4random_uniform(10)%2 ? @"login_video" : @"loginmovie";
        
        _player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4"] withOptions:[IJKFFOptions optionsByDefault]];
        
        //播放视图大小
        _player.view.frame = self.view.bounds;
        
        //填充player
        _player.scalingMode = IJKMPMovieScalingModeAspectFill;
        
        //设置自动播放
        _player.shouldAutoplay = NO;
        
        //准备播放
        [_player prepareToPlay];
        
        [self.view addSubview:_player.view];
        
    }
    
    return _player;
}


//封面图片
- (UIImageView *)coverView{
    
    if (_coverView == nil) {
        
        UIImageView *cover = [[UIImageView alloc]initWithFrame:self.view.bounds];
        
        cover.image = [UIImage imageNamed:@"LaunchImage"];
        
        [self.player.view addSubview:cover];
        
        _coverView = cover;
    }
    
    return _coverView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self notificationOfPlayer];
    
    [self coverView];
}

//监听背景视频播放
- (void) notificationOfPlayer{
    //监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];

}


- (void) stateDidChange{
    
    __weak typeof(self) weakSelf = self;
    
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        
        if (!self.player.isPlaying) {
            
            [self.view insertSubview:self.coverView atIndex:0];
            
            [self.player play];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                
                weakSelf.thirdView.hidden = NO;
                
                weakSelf.loginBtn.hidden = NO;
            });
        }
    }

}


- (void) didFinish{
    
    //播放完之后继续播放
    [self.player play];

}


- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.player play];

}


- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.player pause];
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
