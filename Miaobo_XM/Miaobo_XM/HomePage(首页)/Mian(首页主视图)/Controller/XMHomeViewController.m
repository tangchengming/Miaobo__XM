//
//  XMHomeViewController.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/20.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMHomeViewController.h"
#import "XMCustomTitleView.h"
#import "XMCustomScrollView.h"
#import "XMSearchViewController.h"
#import "RankingListViewController.h"
#import "UIButton+Extension.h"
@interface XMHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic , weak) XMCustomScrollView *CustomScrollView;

@property (nonatomic , weak) XMCustomTitleView *CustomTitleView;

@end

@implementation XMHomeViewController


- (XMCustomScrollView *)CustomScrollView{
    
    if (!_CustomScrollView) {
        
        XMCustomScrollView *CustomScrollView = [[XMCustomScrollView alloc]init];
        
        CustomScrollView.vc = self;
        CustomScrollView.delegate = self;
        self.view = CustomScrollView;
        _CustomScrollView = CustomScrollView;
    }

    return _CustomScrollView;
}

- (XMCustomTitleView *)CustomTitleView{
    
    if (!_CustomTitleView) {
        
        XMCustomTitleView *CustomTitleView = [[XMCustomTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.5, 40)];
        
        //点击按钮移动scrollview
        [CustomTitleView setSelectedBlock:^(Type tag) {
            [UIView animateWithDuration:0.2 animations:^{
                
                self.CustomScrollView.contentOffset = CGPointMake(tag * kScreenWidth, 0);
            }];
        }];
        
        self.navigationItem.titleView = CustomTitleView;
        
        _CustomTitleView = CustomTitleView;
    }
    return _CustomTitleView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIButton show];
    [self setupBasic];
}


- (void)setupBasic{
    
    [self CustomTitleView];
    [self CustomScrollView];
    //搜索
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    
    //排行榜
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(crownRank)];
}

- (void)search{

    XMSearchViewController *search = [[XMSearchViewController alloc]init];
    
    search.title = @"搜索";
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(40, 60, self.view.width - 80, 30)];
    
    [search.view addSubview:searchBar];
    
    [self.navigationController pushViewController:search animated:YES];
}

- (void)crownRank{

    RankingListViewController *crownRank = [[RankingListViewController alloc]init];
    
    crownRank.title = @"排行榜";
    crownRank.urlStr = Request_Method_PHBAnch;
    [self.navigationController pushViewController:crownRank animated:YES];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //屏幕宽度除以两个中心点之间的距离得到百分比
    CGFloat scale = kScreenWidth / ((self.CustomTitleView.width - 36) / 2);
    self.CustomScrollView.contentOffset = CGPointMake(self.CustomScrollView.contentOffset.x, 0);
    
    //18是第一次中心点的坐标因为是以中心点去的点所以每次都要加上。第一次中心点坐标为0；
    self.CustomTitleView.underLine.centerX = self.CustomScrollView.contentOffset.x / scale + 18;
    
    self.CustomTitleView.type = self.CustomScrollView.contentOffset.x / kScreenWidth + 0.5;
    
    self.CustomScrollView.contenOffsetX = self.CustomScrollView.contentOffset.x;
    

}







@end
