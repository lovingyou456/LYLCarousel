//
//  YLLunBoQi.m
//  图片轮播器
//
//  Created by 李灯涛 on 2017/3/28.
//  Copyright © 2017年 李灯涛. All rights reserved.
//

#import "YLLunBoQi.h"
#import "UIButton+WebCache.h"

@interface YLLunBoQi()<UIScrollViewDelegate>

/** 图片轮播器 */
@property(nonatomic, weak) UIScrollView * scrollView;

/** 当前显示的图片 */
@property(nonatomic, assign) NSInteger currentPage;

/** 前一张图片 */
@property(nonatomic, weak) UIButton * imageButton1;

/** 当前显示图片 */
@property(nonatomic, weak) UIButton * imageButton2;

/** 后一张图片 */
@property(nonatomic, weak) UIButton * imageButton3;

/** 图片轮播器定时器 */
@property(nonatomic, strong) NSTimer * timer;

/** 页数指示器 */
@property(nonatomic, weak) UIPageControl * pageControl;

/** 计时器跳过此次调用 */
@property(nonatomic, assign, getter=isJumpScheduled) BOOL jumpScheduled;

/** 轮播器图片更换调用时间间隔(秒) */
@property(nonatomic, assign) NSTimeInterval timeInterval;

@end

@implementation YLLunBoQi

-(instancetype)initWithTimeInterval:(NSTimeInterval)timeInterVal
{
    self = [super init];
    if(self) {
        self.timeInterval = timeInterVal;
        [self initSubViews];
    }
    
    return self;
}

#pragma mark --添加子控件,布局子控件--
-(void)initSubViews
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self.timer fire];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
        
    CGFloat pageWidth = frame.size.width;
    CGFloat pageHeight = 15.0;
    CGFloat pageX = (frame.size.width - pageWidth) * 0.5;
    CGFloat pageY = frame.size.height - pageHeight * 2;
    
    [self.pageControl setFrame:CGRectMake(pageX, pageY, pageWidth, pageHeight)];
    
    [self.scrollView setFrame:self.bounds];
    [self.scrollView setContentSize:CGSizeMake(self.bounds.size.width * 3.0, 0)];
    
    [self.imageButton1 setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.imageButton2 setFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.imageButton3 setFrame:CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];

}

#pragma mark --按钮点击事件--
-(void)didButtonClicked:(UIButton *)button
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([_delegate respondsToSelector:@selector(YLLunBoqi:didImageClickedWithIndex:)]) {
            [_delegate YLLunBoqi:self didImageClickedWithIndex:_currentPage];
        }
    });
}

#pragma mark --重写set方法--
-(void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentPage = 0;
        [self.pageControl setNumberOfPages:imageUrls.count];
    });
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    
    [self changeImages];
}

-(void)changeImages
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSInteger index1, index2, index3;
        
        index2 = _currentPage;
        
        if(_currentPage == 0) {
            index1 = self.imageUrls.count - 1;
            index3 = _currentPage + 1;
        }else if(_currentPage == self.imageUrls.count - 1) {
            index1 = _currentPage - 1;
            index3 = 0;
        }else {
            index1 = _currentPage - 1;
            index3 = _currentPage + 1;
        }
        
        UIImage *placeHolderImage = [UIImage imageNamed:self.placeholderImageName];
        
        [self.imageButton1 sd_setImageWithURL:[NSURL URLWithString:self.imageUrls[index1]] forState:UIControlStateNormal placeholderImage:placeHolderImage];
        [self.imageButton2 sd_setImageWithURL:[NSURL URLWithString:self.imageUrls[index2]] forState:UIControlStateNormal placeholderImage:placeHolderImage];
        [self.imageButton3 sd_setImageWithURL:[NSURL URLWithString:self.imageUrls[index3]] forState:UIControlStateNormal placeholderImage:placeHolderImage];
        
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
        
    });
}

#pragma mark --UIScrollViewDelegate Methods--
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger currentpage = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if(currentpage == 0) {
        
        if(_currentPage == 0) {
            _currentPage = self.imageUrls.count;
        }
        
        _currentPage--;
    }else if(currentpage == 2) {
        
        if(_currentPage == self.imageUrls.count - 1) {
            _currentPage = -1;
        }
        
        _currentPage++;
    }else {
        return;
    }
    
    [self changeImages];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat index = (scrollView.contentOffset.x - scrollView.bounds.size.width) / scrollView.bounds.size.width + 0.5;
    
    
    if(index < 0.0) {
        
        if(_currentPage == 0) {
            [self.pageControl setCurrentPage:self.imageUrls.count - 1];
        }else {
            [self.pageControl setCurrentPage:_currentPage + index];
        }
        
    }else if(index > 1.0){
        
        if(_currentPage == self.imageUrls.count - 1) {
            [self.pageControl setCurrentPage:0];
        }else {
            [self.pageControl setCurrentPage:_currentPage + index];
            
        }
    }else {
        [self.pageControl setCurrentPage:_currentPage + index];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    self.jumpScheduled = YES;
    
    [self.timer setFireDate:[NSDate distantPast]];
}

#pragma mark --懒加载--

-(UIPageControl *)pageControl
{
    if(_pageControl == nil) {
        UIPageControl * pageControl = [UIPageControl new];
        
        [pageControl setUserInteractionEnabled:NO];
        
        _pageControl = pageControl;
        
        return pageControl;
    }
    
    return _pageControl;
}

-(NSTimer *)timer
{
    if(_timer == nil) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval <= 0.1 ? 3.0 : self.timeInterval repeats:YES block:^(NSTimer * timer) {
            if(!self.isJumpScheduled) {
                
                [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * 2, 0) animated:YES];
            }
            
            self.jumpScheduled = NO;
        }];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    return _timer;
}

-(UIButton *)imageButton1
{
    if(_imageButton1 == nil) {
        UIButton * imageButton1 = [UIButton new];
        
        [imageButton1 setAdjustsImageWhenHighlighted:NO];
        [imageButton1.imageView.layer setMasksToBounds:YES];
        [imageButton1.imageView setContentMode:UIViewContentModeScaleAspectFill];
        _imageButton1 = imageButton1;
        
        return imageButton1;
    }
    
    return _imageButton1;
}

-(UIButton *)imageButton2
{
    if(_imageButton2 == nil) {
        UIButton * imageButton2 = [UIButton new];
        
        [imageButton2 setAdjustsImageWhenHighlighted:NO];
        
        [imageButton2.imageView.layer setMasksToBounds:YES];
        [imageButton2.imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        [imageButton2 addTarget:self action:@selector(didButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _imageButton2 = imageButton2;
        
        return imageButton2;
    }
    
    return _imageButton2;
}

-(UIButton *)imageButton3
{
    if(_imageButton3 == nil) {
        UIButton * imageButton3 = [UIButton new];
        
        [imageButton3 setAdjustsImageWhenHighlighted:NO];
        [imageButton3.imageView.layer setMasksToBounds:YES];
        [imageButton3.imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        _imageButton3 = imageButton3;
        
        return imageButton3;
    }
    
    return _imageButton3;
}

-(UIScrollView *)scrollView
{
    if(_scrollView == nil) {
        UIScrollView * scrollView = [UIScrollView new];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setPagingEnabled:YES];
        [scrollView setScrollEnabled:YES];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        
        [scrollView setDelegate:self];
        
        [scrollView addSubview:self.imageButton1];
        [scrollView addSubview:self.imageButton2];
        [scrollView addSubview:self.imageButton3];
        
        _scrollView = scrollView;
        
        return scrollView;
    }
    
    return _scrollView;
}


@end
