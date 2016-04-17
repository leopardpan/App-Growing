//
//  UITableView+Flexible.m
//  App-Growing
//
//  Created by baixinpan on 16/4/17.
//  Copyright © 2016年 leopard. All rights reserved.
//

#import "UITableView+Flexible.h"

static NSString * const kContentOffset = @"contentOffset";
static const CGFloat MaxHeight = 200;


@interface Flexible : UIImageView

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation Flexible

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:kContentOffset];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:kContentOffset options:NSKeyValueObservingOptionNew context:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.scrollView.contentOffset.y < 0) {
        CGFloat offset = -self.scrollView.contentOffset.y;
        
        self.frame = CGRectMake(-offset, -offset, _scrollView.bounds.size.width + offset * 2, MaxHeight + offset);
    } else {
        self.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, MaxHeight);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsLayout];
}

@end


@implementation UIScrollView (Flexible)

- (void)addFlexibleImage:(UIImage *)image
{
    if (!image) {
        return;
    }
    
    Flexible *flexible = [[Flexible alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, MaxHeight)];
    
    flexible.backgroundColor = [UIColor clearColor];
    flexible.image = image;
    flexible.scrollView = self;
    
    [self addSubview:flexible];
    [self sendSubviewToBack:flexible];
}

@end
