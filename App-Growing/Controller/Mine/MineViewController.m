//
//  MineViewController.m
//  App-Growing
//
//  Created by 潘柏信 on 16/4/14.
//  Copyright © 2016年 leopard. All rights reserved.
//

#import "MineViewController.h"
#import "UITableView+Flexible.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    // Do any additional setup after loading the view.
}

- (void)setupTableView
{
    [self.tableView addFlexibleImage:[UIImage imageNamed:@"003.jpg"]];
}

@end
