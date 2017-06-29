//
//  YQLWebView.m
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/27.
//  Copyright © 2017年 qianxx. All rights reserved.
//

// github 地址： https://github.com/Dogndxt/YQLWebViewProgress
// 欢迎大家交流学习，如果对您有帮助，希望给我找个项目点个 star ～，谢谢～


#import "YQLWebView.h"
#import "YQLWebViewProgressView.h"

#define DefaultProgressHeight 2.0f

@interface YQLWebView ()

@property (nonatomic, strong) YQLWebViewProgress *webViewProgress;
@property (nonatomic, strong) YQLWebViewProgressView *webViewProgressView;

@end

@implementation YQLWebView  

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configure];
}

- (void)configure {
    _webViewProgress = [[YQLWebViewProgress alloc] init];
    self.delegate = _webViewProgress;
    _webViewProgress.progressDelegate = self;

    if (!self.progressHeight) {
        self.progressHeight = DefaultProgressHeight;
    }
    CGRect progressBounds = CGRectMake(0, 0, self.bounds.size.width, self.progressHeight);
    _webViewProgressView = [[YQLWebViewProgressView alloc] initWithFrame:progressBounds color:self.progressColor];
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.scrollView addSubview:_webViewProgressView];
}

- (void)setUrlStr:(NSString *)urlStr {

    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [self loadRequest:req];
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    [self reBuildProgressView];
}

- (void)setProgressHeight:(double)progressHeight {
    _progressHeight = progressHeight;
    if (progressHeight != DefaultProgressHeight) {
        [self reBuildProgressView];
    }
}

- (void)reBuildProgressView {
    [_webViewProgressView removeFromSuperview];
    if (!self.progressHeight) {
        self.progressHeight = DefaultProgressHeight;
    }
    CGRect progressBounds = CGRectMake(0, 0, self.bounds.size.width, _progressHeight);
    _webViewProgressView = [[YQLWebViewProgressView alloc] initWithFrame:progressBounds color:_progressColor];
    [self.scrollView addSubview:_webViewProgressView];
}

#pragma mark - YQLWebViewProgressDelegate
- (void)webViewProgress:(YQLWebViewProgress *)webviewProgress updateProgress:(double)progress {
    [_webViewProgressView setProgress:progress animated:YES];
}

@end
