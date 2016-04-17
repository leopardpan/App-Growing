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

#import "AFNetworking.h"

@interface HomePageViewController ()<BannerViewDelegate>

@property (weak, nonatomic) IBOutlet BannerView *bannerView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTestData];
    [self setupBannerView];
}

- (void)getTestData {
    
    NSString *url = @"http://192.168.3.104:4000/todos";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
      
        NSLog(@"obj = %@",obj);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"error = %@",error);
        NSLog(@"code = %ld", operation.response.statusCode);
    }];
}

- (void)setupBannerView {
    _bannerView.delegate = self;
    
    NSMutableArray *bannerItems = [NSMutableArray array];
    [bannerItems addObject:[BannerItem imgName:@"001.jpg" label:@"第一页"]];
    [bannerItems addObject:[BannerItem imgName:@"002.jpg"  label:@"第二页"]];
    [bannerItems addObject:[BannerItem imgName:@"003.jpg"  label:@"第三页"]];
    [bannerItems addObject:[BannerItem imgName:@"004.jpg"  label:@"第四页"]];
    [bannerItems addObject:[BannerItem imgName:@"005.jpg"  label:@"第五页"]];
    [_bannerView reloadData:bannerItems];
}

#pragma mark - BannerViewDelegate

- (void)BannerView:(BannerView *)bannerControl didScrollToIndex:(NSUInteger)index {
//    NSLog(@"ScrollTo:%zd",index);
}

- (void)BannerView:(BannerView *)bannerControl didTouchAtIndex:(NSUInteger)index {
//    NSLog(@"TouchOnPage:%zd",index);
}

@end

