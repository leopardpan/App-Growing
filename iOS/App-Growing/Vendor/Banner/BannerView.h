//
//  BannerView.h
//  App-Growing
//
//  Created by 潘柏信 on 16/4/15.
//  Copyright © 2016年 leopard. All rights reserved.
//
// 实例化三个 ImageVew 实现无限轮播。
// 已知 Bug: 滑快了， 后面的图片加载不出来， 待继续优化。。。

#import <UIKit/UIKit.h>

@class BannerView;

@protocol BannerViewDelegate <NSObject>

- (void)BannerView:(BannerView *)bannerView didScrollToIndex:(NSUInteger)index;
- (void)BannerView:(BannerView *)bannerView didTouchAtIndex:(NSUInteger)index;

@end

@interface BannerView : UIView

@property (nonatomic, weak) id <BannerViewDelegate> delegate;

- (void)reloadData:(NSArray *)items;

@end



