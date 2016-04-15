//
//  BannerView.m
//  App-Growing
//
//  Created by 潘柏信 on 16/4/15.
//  Copyright © 2016年 leopard. All rights reserved.
//

#import "BannerView.h"
#import "BannerItem.h"

typedef NS_ENUM(NSInteger,Page){
    PrevPage = 0,
    CurrPage = 1,
    NextPage = 2,
};

@interface BannerView()<UIScrollViewDelegate>
@end

@implementation BannerView {
    NSTimeInterval _interval;
    
    NSUInteger      _prevIndex;
    NSUInteger      _currIndex;
    NSUInteger      _nextIndex;

    UIImageView    *_prevImageView;
    UIImageView    *_currImageView;
    UIImageView    *_nextImageView;
    
    NSMutableArray *_dataSource;
    UIScrollView   *_scrollView;
    
    BOOL _isManualSlide;
    NSMutableDictionary *_dataCache;
}

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self doInitWork];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self doInitWork];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self doInitWork];
    }
    return self;
}

- (void)doInitWork {
    [self setupVars];
    [self setupScrollView];
    [self setupImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchOnPage:)];
    [self addGestureRecognizer:tap];
}

- (void)setupVars {
    _interval   = 5.0;
    _prevIndex  = 0;
    _currIndex  = 0;
    _nextIndex  = 0;
    _dataSource = [NSMutableArray array];
    _dataCache  = [NSMutableDictionary dictionary];
}

- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate                       = self;
    _scrollView.pagingEnabled                  = YES;
    _scrollView.scrollsToTop                   = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    [self layoutScrollView];
}

- (void)setupImageView {
    _prevImageView = [[UIImageView alloc] init];
    _currImageView = [[UIImageView alloc] init];
    _nextImageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_prevImageView];
    [_scrollView addSubview:_currImageView];
    [_scrollView addSubview:_nextImageView];
    
    [self layoutImageViews];
}

/**  每次加载数据前 remove imageView ， 防止数据重复，导致混乱 */
- (void)unsetupllImageView {
    [_prevImageView removeFromSuperview];
    [_currImageView removeFromSuperview];
    [_nextImageView removeFromSuperview];
}

- (void)layoutScrollView {
    CGSize size = self.bounds.size;
    _scrollView.frame = CGRectMake(0, 0, size.width, size.height);
    _scrollView.contentSize = CGSizeMake(3 * size.width, size.height);
}

- (void)layoutImageViews {
    CGSize size = self.bounds.size;
    _prevImageView.frame = CGRectMake(0, 0, size.width, size.height);
    _currImageView.frame = CGRectMake(size.width, 0, size.width, size.height);
    _nextImageView.frame = CGRectMake(2 * size.width, 0, size.width, size.height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutScrollView];
    [self layoutImageViews];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutIfNeeded];
}

#pragma mark - API
- (void)reloadData:(NSArray *)items {

    if (!items) return;

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAutoScroll) object:nil];
    
    [_dataSource removeAllObjects];
    [_dataSource addObjectsFromArray:items];
    
    static BOOL needSetupImageViews = NO;
    if (_dataSource.count == 0) {
        [self unsetupllImageView];
        needSetupImageViews = YES;
        return;
    } if (needSetupImageViews) {
        [self setupImageView];
    }
    
    _currIndex = 0;
    _prevIndex = (_dataSource.count > 1) ? (_dataSource.count - 1) : 0;
    _nextIndex = (_dataSource.count > 1) ? 1: 0;
    [self loadItemData:_prevIndex onPage:PrevPage];
    [self loadItemData:_currIndex onPage:CurrPage];
    [self loadItemData:_nextIndex onPage:NextPage];
    
    CGSize size = _scrollView.bounds.size;
    [_scrollView scrollRectToVisible:CGRectMake(size.width, 0, size.width, size.height) animated:NO];
    [_delegate BannerView:self didScrollToIndex:_currIndex];
    
    [self performSelector:@selector(startAutoScroll) withObject:nil afterDelay:_interval];
}

- (void)startAutoScroll {
    CGSize size = _scrollView.bounds.size;
    [_scrollView scrollRectToVisible:CGRectMake(size.width*2, 0, size.width, size.height) animated:YES];
    [self performSelector:@selector(startAutoScroll) withObject:nil afterDelay:_interval];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self responseForScroll];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 手动滚动
    if (scrollView.tracking || scrollView.dragging) {
        _isManualSlide = YES;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAutoScroll) object:nil];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self responseForScroll];
    // 复自动滚动
    if (_isManualSlide) {
        [self performSelector:@selector(startAutoScroll) withObject:nil afterDelay:_interval];
        _isManualSlide = NO;
    }
}

- (void)responseForScroll {
    CGSize size = _scrollView.bounds.size;
    // 向左滑动
    if (_scrollView.contentOffset.x > size.width) {
        [self loadItemData:_currIndex onPage:PrevPage];
        _currIndex = (_currIndex >= _dataSource.count - 1) ? 0 : (_currIndex + 1);
        [self loadItemData:_currIndex onPage:CurrPage];
        _nextIndex = (_currIndex >= _dataSource.count - 1) ? 0 : (_currIndex + 1);
        [self loadItemData:_nextIndex onPage:NextPage];
    }
    
    // 向右滑动
    if (_scrollView.contentOffset.x < size.width) {
        [self loadItemData:_currIndex onPage:NextPage];
        _currIndex = (_currIndex == 0) ? (_dataSource.count - 1) : (_currIndex - 1);
        [self loadItemData:_currIndex onPage:CurrPage];
        _prevIndex = (_currIndex == 0) ? (_dataSource.count - 1) : (_currIndex - 1);
        [self loadItemData:_prevIndex onPage:PrevPage];
    }
    
    [_scrollView scrollRectToVisible:CGRectMake(size.width, 0, size.width, size.height) animated:NO];
    [_delegate BannerView:self didScrollToIndex:_currIndex];
}

- (void)loadItemData:(NSUInteger)itemDataIndex onPage:(NSUInteger)pageIndex {
    if (itemDataIndex >= _dataSource.count) return;
    BannerItem *item = [_dataSource objectAtIndex:itemDataIndex];
    if (![item isKindOfClass:[BannerItem class]]) {
        return;
    }
    
    switch(pageIndex) {
        case PrevPage:
            [self loadImageData:item forView:_prevImageView];
            break;
        case CurrPage:
            [self loadImageData:item forView:_currImageView];
            break;
        case NextPage:
            [self loadImageData:item forView:_nextImageView];
            break;
        default:break;
    }
}

/** 给缓存池里面的 ImageView 赋值具体的图片*/
- (void)loadImageData:(BannerItem *)item forView:(UIImageView *)imageView {
    
    UIImage *cacheImage = [_dataCache objectForKey:item.imgName];
    if (cacheImage) {
        imageView.image = cacheImage;
        return;
    }
    UIImage *image  = [UIImage imageNamed:item.imgName];
    imageView.image = image;
    [_dataCache setObject:image forKey:item.imgName];
}

#pragma mark - Touch event
- (void)touchOnPage:(UITapGestureRecognizer *)tapGesture {
    [_delegate BannerView:self didTouchAtIndex:_currIndex];
}

@end

