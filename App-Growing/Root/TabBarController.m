//
//  TabBarController.m
//  App-Growing
//
//  Created by 潘柏信 on 16/4/15.
//  Copyright © 2016年 leopard. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "RDVTabBarItem.h"

#import "HomePageViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"

#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"


@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    [self customizeInterface];
    
    // Do any additional setup after loading the view.
}

- (void)setupViewControllers {
    
    // homepage
    HomePageViewController *hpVC = [[HomePageViewController alloc] init];
    hpVC.title = @"主页";
    NavigationController *navHp = [[NavigationController alloc] initWithRootViewController:hpVC];
    
    // discover
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    DiscoverViewController *disVC = [[DiscoverViewController alloc] initWithTitle:@"发现" andSubTitles:@[@"视图1", @"视图2", @"视图3", @"视图4"]andControllers:@[vc1, vc2, vc3,vc4] underTabbar:NO];
    NavigationController *navDic = [[NavigationController alloc] initWithRootViewController:disVC];
    
    // mine
    MineViewController *mineVC = [[MineViewController alloc] init];
    mineVC.title = @"我的";
    NavigationController *navMine = [[NavigationController alloc] initWithRootViewController:mineVC];
    
    [self setViewControllers:@[navHp, navDic,navMine]];
    
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"Tab_Discover", @"Tab_Me"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end
