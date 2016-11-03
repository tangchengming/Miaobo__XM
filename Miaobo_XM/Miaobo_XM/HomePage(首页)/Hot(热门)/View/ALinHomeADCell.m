//
//  ALinHomeADCell.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 2016/10/31.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "ALinHomeADCell.h"

@implementation ALinHomeADCell

- (void)setHeaderModels:(NSArray *)headerModels{
    _headerModels  = headerModels;
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (XMHotHeaderModel *headerModel in headerModels) {
        [imageUrls addObject:headerModel.imageUrl];
    }
    XRCarouselView *view = [XRCarouselView carouselViewWithImageArray:imageUrls describeArray:nil];
    view.time = 2.0;
    view.delegate = self;
    view.frame = self.contentView.bounds;
    //移除之前的view
    [self.contentView addSubview:view];
}

#pragma mark - XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{
    if (self.imageClickBlock) {
        self.imageClickBlock(self.headerModels[index]);
    }
}

@end
