//
//  ViewController.m
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/27.
//  Copyright © 2017年 qianxx. All rights reserved.
//

#import "ViewController.h"
#import "YQLWebView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YQLWebView *webView = [[YQLWebView alloc] initWithFrame:self.view.bounds];
    webView.urlStr = @"https://google.com/";
    webView.progressColor = [UIColor redColor];
    webView.progressHeight = 10.0;
    [self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
