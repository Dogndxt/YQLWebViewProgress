//
//  YQLWebViewProgress.h
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/27.
//  Copyright © 2017年 qianxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol YQLWebViewProgressDelegate;

@interface YQLWebViewProgress : NSObject <UIWebViewDelegate, NSCoding>

@property (nullable, nonatomic) void (^YQLWebViewProgressBlock)(double progress);

@property (nonatomic, nullable, assign) id <YQLWebViewProgressDelegate> progressDelegate;
@property (nonatomic, nullable, assign) id <UIWebViewDelegate> webViewDelegate;

@property (nonatomic, readonly) double progress;

@end

@protocol YQLWebViewProgressDelegate <NSObject>

- (void)webViewProgress:(nullable YQLWebViewProgress *)webviewProgress updateProgress:(double)progress;

@end
