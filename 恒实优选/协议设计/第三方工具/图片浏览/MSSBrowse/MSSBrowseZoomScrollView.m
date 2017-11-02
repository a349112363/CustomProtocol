//
//  MSSBrowseZoomScrollView.m
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "MSSBrowseZoomScrollView.h"
#import "MSSBrowseDefine.h"

@interface MSSBrowseZoomScrollView ()

@property (nonatomic,copy)MSSBrowseZoomScrollViewTapBlock tapBlock;
@property (nonatomic,assign)BOOL isSingleTap;
@property (nonatomic,assign) NSInteger number;
@end

@implementation MSSBrowseZoomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createZoomScrollView];
    }
    return self;
}

- (void)createZoomScrollView
{
    self.delegate = self;
    _isSingleTap = NO;
    self.minimumZoomScale = 1.0f;
    self.maximumZoomScale = 3.0f;
    
    _zoomImageView = [[UIImageView alloc]init];
    _zoomImageView.userInteractionEnabled = YES;
    [self addSubview:_zoomImageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _zoomImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // 延中心点缩放
    CGRect rect = _zoomImageView.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    if (rect.size.width < self.mssWidth) {
        rect.origin.x = floorf((self.mssWidth - rect.size.width) / 2.0);
    }
    if (rect.size.height < self.mssHeight) {
        rect.origin.y = floorf((self.mssHeight - rect.size.height) / 2.0);
    }
    _zoomImageView.frame = rect;
}

- (void)tapClick:(MSSBrowseZoomScrollViewTapBlock)tapBlock
{
    _tapBlock = tapBlock;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = touches.anyObject;
    
    //判断是单击还是双击
    _isSingleTap = NO;
    
    //记录点击次数
    self.number ++;
    //单击处理
    if(self.number == 1)
    {
        
        //延迟0.5s 执行单击事件
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (_isSingleTap == YES) return;
            
            [self singleTapClick];
            
        });
        
    }
    else
    {
        //双击的时候 不执行单击
        _isSingleTap = YES;
        
        //   [NSObject cancelPreviousPerformRequestsWithTarget:self];
        // 防止先执行单击手势后还执行下面双击手势动画异常问题
        if(_isSingleTap)
        {
            CGPoint touchPoint = [touch locationInView:_zoomImageView];
            [self zoomDoubleTapWithPoint:touchPoint];
            self.number = 0;
        }
    }
    
    
    
}

- (void)singleTapClick
{
    if(_tapBlock)
    {
        _tapBlock();
    }
}

- (void)zoomDoubleTapWithPoint:(CGPoint)touchPoint
{
    if(self.zoomScale > self.minimumZoomScale)
    {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
    else
    {
        CGFloat width = self.bounds.size.width / self.maximumZoomScale;
        CGFloat height = self.bounds.size.height / self.maximumZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - width / 2, touchPoint.y - height / 2, width, height) animated:YES];
    }
}


@end
