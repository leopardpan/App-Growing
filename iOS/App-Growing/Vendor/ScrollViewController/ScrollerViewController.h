//
//  ScrollerViewController.h
//  ScrollDemo
//
//  Created by baixinpan on 16/4/12.
//  Copyright © 2016年 baixinpan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleBarView.h"
#import "HorizonalTableViewController.h"

@interface ScrollerViewController : UIViewController

@property (nonatomic, strong) HorizonalTableViewController *viewPager;
@property (nonatomic, strong) TitleBarView *titleBar;

- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers underTabbar:(BOOL)underTabbar;
- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers;
- (void)scrollToViewAtIndex:(NSUInteger)index;

@end

