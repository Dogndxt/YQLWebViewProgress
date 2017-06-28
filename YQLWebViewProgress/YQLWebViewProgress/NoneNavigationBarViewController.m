//
//  NoneNavigationBarViewController.m
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/28.
//  Copyright © 2017年 qianxx. All rights reserved.
//

#import "NoneNavigationBarViewController.h"
#import "YQLWebView.h"

@interface NoneNavigationBarViewController ()

@end

@implementation NoneNavigationBarViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    YQLWebView *webView = [[YQLWebView alloc] initWithFrame:self.view.bounds];
    webView.urlStr = @"https://google.com/";
    webView.progressColor = [UIColor redColor];
    webView.progressHeight = 10.0;
    [self.view addSubview:webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
