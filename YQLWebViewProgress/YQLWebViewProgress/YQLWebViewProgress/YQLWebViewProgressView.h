//
//  YQLWebViewProgressView.h
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/27.
//  Copyright © 2017年 qianxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface YQLWebViewProgressView : UIView {

    NSTimeInterval _animationDuration;
    NSTimeInterval _fadeAnimationDuration;
    NSTimeInterval _fadeOutAnimationDuration;
}

@property (nonatomic, assign) double progress;

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) NSTimeInterval fadeAnimationDuration;
@property (nonatomic, assign) NSTimeInterval fadeOutAnimationDuration;


- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;

- (void)setProgress:(double)progress animated:(BOOL)animated;


@end
