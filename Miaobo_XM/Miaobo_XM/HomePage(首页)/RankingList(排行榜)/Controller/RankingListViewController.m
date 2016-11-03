//
//  RankingListViewController.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/21.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "RankingListViewController.h"

@interface RankingListViewController ()

@end

@implementation RankingListViewController

- (UIWebView *)webView{
    
    if (!_webView) {
        
        UIWebView *webView = [[UIWebView alloc]init];
        
        [self.view addSubview:webView];
        
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(self.view);
            make.height.equalTo(self.view);
            make.center.equalTo(self.view);
        }];
        
        _webView = webView;
    }

    return _webView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webView loadRequest:request];
}


@end
