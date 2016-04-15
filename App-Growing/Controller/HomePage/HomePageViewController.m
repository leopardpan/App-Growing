//
//  HomePageViewController.m
//  App-Growing
//
//  Created by 潘柏信 on 16/4/14.
//  Copyright © 2016年 leopard. All rights reserved.
//

#import "HomePageViewController.h"
#import "BannerView.h"
#import "BannerItem.h"

@interface HomePageViewController ()<BannerViewDelegate>

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBannerView];
    
}

- (void)setupBannerView {

    NSMutableArray *bannerItems = [NSMutableArray array];
    [bannerItems addObject:[BannerItem imgName:@"001.jpg" label:@"第一页"]];
    [bannerItems addObject:[BannerItem imgName:@"002.jpg"  label:@"第二页"]];
    [bannerItems addObject:[BannerItem imgName:@"003.jpg"  label:@"第三页"]];
    [bannerItems addObject:[BannerItem imgName:@"004.jpg"  label:@"第四页"]];
    [bannerItems addObject:[BannerItem imgName:@"005.jpg"  label:@"第五页"]];
    BannerView *bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];
    bannerView.delegate = self;
    [bannerView reloadData:bannerItems];
    [self.view addSubview:bannerView];

}

#pragma mark - BannerViewActionHandler

- (void)BannerView:(BannerView *)bannerControl didScrollToIndex:(NSUInteger)index {
    NSLog(@"ScrollTo:%zd",index);
}

- (void)BannerView:(BannerView *)bannerControl didTouchAtIndex:(NSUInteger)index {
    NSLog(@"TouchOnPage:%zd",index);
}

@end

