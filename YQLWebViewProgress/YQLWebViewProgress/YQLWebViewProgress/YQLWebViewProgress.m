//
//  YQLWebViewProgress.m
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/27.
//  Copyright © 2017年 qianxx. All rights reserved.
//

#import "YQLWebViewProgress.h"

@interface YQLWebViewProgress () {

    NSUInteger _loadingCount;
    NSUInteger _maxLoadCount;
    NSURL *_currentURL;
}

@property (nonatomic, assign, readonly) double initialProgressValue;
@property (nonatomic, assign, readonly) double interactiveProgressValue;
@property (nonatomic, assign, readonly) double finalProgressValue;

@property (nonatomic, assign) NSUInteger loadingCount;
@property (nonatomic, assign) NSUInteger maxLoadCount;
@property (nonatomic, strong) NSURL *currentURL;

@end

@implementation YQLWebViewProgress

- (nullable instancetype)init {

    self = [super init];
    if (self) {
        _maxLoadCount = _loadingCount = 1;
        _initialProgressValue = 0.1f;
        _interactiveProgressValue = 0.5f;
        _finalProgressValue = 0.9f;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {

    return [super init];
}

- (void)encodeWithCoder:(NSCoder *)coder {

}

/**
 设定初始进度值
 */
- (void)startProgress {
    if (_progress < _initialProgressValue) {
        [self setProgress:_progress];
    }
}


/**
 设定变化的进度值
 */
- (void)incrementProgress {
    double progress = self.progress;
    double maxProgress =  _finalProgressValue;
    double currentPercent = (double)_loadingCount / (double)_maxLoadCount;
    double increase = (maxProgress - progress) * currentPercent;
    progress += increase;
    progress = fmin(progress, maxProgress);
    [self setProgress:progress];
}


/**
 完成进度
 */
- (void)completeProgress {
    [self setProgress:1.0];
}


/**
 重置数据
 */
- (void)reset {
    _maxLoadCount = 1;
    _loadingCount = 0;
    _progress = 0.0;
}


/**
  设置进度变化，将变化的值给他代理

 @param progress 传入的进度值
 */
- (void)setProgress:(double)progress {
    if (progress > _progress || progress == 0) {
        _progress = progress;
        if ([_progressDelegate respondsToSelector:@selector(webViewProgress:updateProgress:)]) {
            [_progressDelegate webViewProgress:self updateProgress:progress];
        }
        if (self.YQLWebViewProgressBlock) {
            self.YQLWebViewProgressBlock(progress);
        }
    }
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL ret = YES;
    if ([_webViewDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        ret = [_webViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    BOOL isEqualFragment = NO;
    if (request.URL.fragment) {
        NSString *fragmentURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:request.URL.fragment] withString:@""];
        isEqualFragment = [fragmentURL isEqualToString:webView.request.URL.absoluteString];
    }
    
    BOOL isMainDocumentURL = [request.mainDocumentURL isEqual:request.URL];
    BOOL isHTTPorHTTPS = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"];
    if (ret && !isEqualFragment && isHTTPorHTTPS && isMainDocumentURL) {
        _currentURL = request.URL;
        [self reset];
    }
    return ret;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([_webViewDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_webViewDelegate webViewDidStartLoad:webView];
    }
    _loadingCount += 1;
    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
    [self startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([_webViewDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_webViewDelegate webViewDidFinishLoad:webView];
    }
    _loadingCount -= 1;
    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
    [self incrementProgress];
    
    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
   
    if (isNotRedirect) {
        [self completeProgress];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([_webViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [_webViewDelegate webView:webView didFailLoadWithError:error];
    }
    
    _loadingCount -= 1;
    [self incrementProgress];
    
    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    
    if (isNotRedirect) {
        [self completeProgress];
    }
}

#pragma mark - Method Fprwarding
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    if ([_webViewDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if ([_webViewDelegate respondsToSelector:aSelector]) {
            return [(NSObject *)_webViewDelegate methodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([_webViewDelegate respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:_webViewDelegate];
    }
}


@end
