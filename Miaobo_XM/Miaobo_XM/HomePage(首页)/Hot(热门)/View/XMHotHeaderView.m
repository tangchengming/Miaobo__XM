//
//  XMHotHeaderView.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/26.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMHotHeaderView.h"

@interface XMHotHeaderView ()<XRCarouselViewDelegate>

@property (nonatomic,weak) UIView *myView;

@property (nonatomic,strong) NSMutableArray *lastModels;

@end


@implementation XMHotHeaderView

- (void)setHeaderModels:(NSArray *)headerModels{
    
    _headerModels = headerModels;
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    
    for (XMHotHeaderModel *headerModel in headerModels) {
        
        [imageUrls addObject:headerModel.imageUrl];
    }

    //如果返回数据和上次一样 直接返回
    if (self.lastModels) return;
    
    self.myView = nil;
    
    [self.myView removeFromSuperview];
    
    XRCarouselView *view = [XRCarouselView carouselViewWithImageArray:imageUrls describeArray:nil];
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        view.time = 2.0;
        view.delegate = weakSelf;
        view.frame = weakSelf.bounds;
        
        //移除之前的view
        [weakSelf addSubview:view];
        
        weakSelf.lastModels = [NSMutableArray arrayWithArray:headerModels];
        weakSelf.myView = view;
    });
}


#pragma mark - XRCarouselViewDelegate

- (void) carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{

    if (self.imageClickBlock) {
        self.imageClickBlock(self.headerModels[index]);
    }
}

@end
