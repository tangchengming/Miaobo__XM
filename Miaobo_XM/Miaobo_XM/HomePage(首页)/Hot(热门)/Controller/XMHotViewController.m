//
//  XMHotViewController.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/28.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMHotViewController.h"
#import "ALinHomeADCell.h"
#import "XMHotTableViewCell.h"
#import "XMHotData.h"
#import "XMHotModel.h"
#import "XMHotHeaderModel.h"
#import "RankingListViewController.h"//web
@interface XMHotViewController ()
//当前页
@property (nonatomic, assign)NSUInteger currentPage;

//直播数据
@property (nonatomic, strong)NSMutableArray *lives;

//广告
@property (nonatomic ,strong) NSArray *headerModels;

@property (nonatomic, strong) XMHotData *hotData;
@end

static NSString *reuseIdentifier = @"XMHotTableViewCell";
static NSString *ADReuseIdentifier = @"ALinHomeADCell";

@implementation XMHotViewController


- (NSMutableArray *)lives{
    
    if (!_lives) {
        
        _lives = [NSMutableArray array];
    }
    
    return _lives;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMHotTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    [self.tableView registerClass:[ALinHomeADCell class] forCellReuseIdentifier:ADReuseIdentifier];
    
    self.currentPage = 1;
    //刷新
    self.tableView.mj_header = [XMinRefreshGifHeader headerWithRefreshingBlock:^{
        
        self.lives = [NSMutableArray array];
        self.currentPage = 1;
        
        //获取顶部广告
        [self getTopAD];
        
        //获取直播信息
        [self getHotLiveList];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.currentPage++;
        [self getHotLiveList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

-(void)getTopAD{
    [RequestManager GetWithSuccess:^(XMHotHeaderResult *result) {
        
        self.headerModels = result.data;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showMessage:@"网络异常"];
    }];

}

-(void)getHotLiveList{

    [RequestManager GetWithHotURL:self.currentPage success:^(ResponseObject *result) {
        
        
        XMHotData *hotData = [XMHotData mj_objectWithKeyValues:result.data];
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (hotData.list) {
            
            [self.lives addObjectsFromArray:hotData.list];
            
            [self.tableView reloadData];
            
        }else{
            
//            [MBProgressHUD showMessage:@"暂时没有更多最新数据"];
            [MBProgressHUD showMessage:@"暂时没有更多最新数据" toView:self.view afterDelty:2.0];
            
            //恢复当前页
            self.currentPage--;
        }
        
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.currentPage--;
        [MBProgressHUD showMessage:@"网络异常"];
    }];

}










#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.lives.count + 1;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    XMHotTableViewCell *cell = [XMHotTableViewCell tableViewCell];
    //    cell.hotModel = self.lives[indexPath.item];
    //
    //    return cell.height;
    
    if (indexPath.row == 0) {
        
        return 100;
    }
    
    return 465;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ALinHomeADCell *cell = [tableView dequeueReusableCellWithIdentifier:ADReuseIdentifier];
        
        if (self.headerModels.count) {
            
            cell.headerModels = self.headerModels;
            //点击cell
            [cell setImageClickBlock:^(XMHotHeaderModel *headerModel) {
                
                if (headerModel.link.length) {
                    
                    RankingListViewController *web = [[RankingListViewController alloc]init];
                    
                    web.title = headerModel.title;
                    web.urlStr = headerModel.link;
                    
                    [self.navigationController pushViewController:web animated:YES];
                }
            }];
        }
        return cell;
    }
    
    XMHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (self.lives.count) {
        
        XMHotModel *live = self.lives[indexPath.row - 1];
        cell.hotModel = live;
    }
    
    return cell;
}




@end
