//
//  XMLoginView.m
//  Miaobo_XM
//
//  Created by 成都众人合 on 16/10/13.
//  Copyright © 2016年 小明. All rights reserved.
//

#import "XMLoginView.h"

@implementation XMLoginView

- (instancetype) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    
    return self;
}


- (void) setupBasic {
    
    [self createBtnWithImage:@"wbLoginicon_60x60" tag:LoginTypeSina];
    
    [self createBtnWithImage:@"qqloginicon_60x60" tag:LoginTypeQQ];
    
    [self createBtnWithImage:@"wxloginicon_60x60" tag:LoginTypeWechat];

}


- (UIButton *)createBtnWithImage:(NSString *)imageName tag:(NSInteger)tag{
    
    UIButton *btn = [[UIButton alloc]init];
    
    btn.image = imageName;
    
    btn.tag = tag;
    
    //自适应大小
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(btnClick:)];
    
    [self addSubview:btn];
    
    
    return btn;
}

- (void) layoutSubviews{
    
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    for (int i = 0; i < count; i++) {
        
        UIButton *btn = self.subviews[i];
        
        CGFloat margin = (kScreenWidth - btn.width * count) / (count + 1);
        
        CGFloat x = (btn.width + margin) * i + margin;
        
        CGFloat y = 0;
        
        btn.frame = CGRectMake(x, y, btn.width, btn.height);
    
    }

}

- (void) btnClick:(UIButton *)btn{
    
    if (self.selectedBlock) {
        self.selectedBlock(btn.tag);
    }

}

@end
