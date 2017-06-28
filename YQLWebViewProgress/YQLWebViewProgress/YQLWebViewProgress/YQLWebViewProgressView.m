//
//  YQLWebViewProgressView.m
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/27.
//  Copyright © 2017年 qianxx. All rights reserved.
//

#import "YQLWebViewProgressView.h"

#define DefaultColor [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0]

@implementation YQLWebViewProgressView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor *color = DefaultColor;
    CGRect frame = CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height);
    [self configViewWithFrame:frame color:color];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *color = DefaultColor;
        [self configViewWithFrame:frame color:color];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color {

    self = [super initWithFrame:frame];
    if (self) {
        if (color) {
            [self configViewWithFrame:frame color:color];
        } else {
            [self configViewWithFrame:frame color:DefaultColor];
        }
    }
    return self;
}
 

/**
 初始化 YQLWebViewProgressView 的大小，颜色

 @param frame 大小
 @param color 颜色
 */
- (void)configViewWithFrame:(CGRect)frame color:(UIColor *)color {

    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressView = [[UIView alloc] initWithFrame:frame];
    _progressView.alpha = 0.0;
    _progressView.backgroundColor = color;
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_progressView];
    
    _animationDuration = 0.25f;
    _fadeAnimationDuration = 0.25f;
    _fadeOutAnimationDuration = 0.1f;
}


/**
 设置进度

 @param progress 进度值
 */
- (void)setProgress:(double)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(double)progress animated:(BOOL)animated {
    BOOL change = progress > 0.0;
    [UIView animateWithDuration:(change && animated) ?  _animationDuration : 0.0 animations:^{
        CGRect frame = _progressView.frame;
        frame.size.width = progress * self.bounds.size.width;
        _progressView.frame = frame;
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    } completion:^(BOOL finished) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
    if (progress >= 1.0) {
        [UIView animateWithDuration:animated ? _animationDuration : 0.0 delay:_fadeOutAnimationDuration options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressView.alpha = 0.0;
        } completion:^(BOOL finished) {
            CGRect frame = _progressView.frame;
            frame.size.width = 0.0;
            _progressView.frame = frame;
        }];
    } else {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressView.alpha = 1.0;
        } completion:nil];
    }
}


@end
