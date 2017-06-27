//
//  YQLWebView.h
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/27.
//  Copyright © 2017年 qianxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQLWebViewProgress.h"

@interface YQLWebView : UIWebView <YQLWebViewProgressDelegate>

/**
 跳转的链接
 */
@property (nonatomic, strong) NSString *urlStr;


/**
 进度条的颜色
 */
@property (nonatomic, strong) UIColor *progressColor;


/**
 进度条的宽度，默认为 2.0px
 */
@property (nonatomic, assign) double progressHeight;

@end
