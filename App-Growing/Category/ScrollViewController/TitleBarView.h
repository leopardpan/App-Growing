//
//  TitleBarView.h
//  ScrollDemo
//
//  Created by baixinpan on 16/4/12.
//  Copyright © 2016年 baixinpan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleBarView : UIScrollView

@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, copy) void (^titleButtonClicked)(NSUInteger index);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray*)titles;

- (void)setTitleButtonsColor;

@end
