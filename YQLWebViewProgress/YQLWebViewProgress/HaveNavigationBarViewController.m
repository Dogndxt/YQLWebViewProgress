//
//  HaveNavigationBarViewController.m
//  YQLWebViewProgress
//
//  Created by qingling_yang on 17/6/28.
//  Copyright © 2017年 qianxx. All rights reserved.
//

#import "HaveNavigationBarViewController.h"
#import "YQLWebView.h"

@interface HaveNavigationBarViewController ()

@property (weak, nonatomic) IBOutlet YQLWebView *yqlWebView;

@end

@implementation HaveNavigationBarViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.yqlWebView.urlStr = @"https://mp.weixin.qq.com/s/demzXh8CHggvRYFGDg";
//    webView.progressColor = [UIColor redColor];
//    webView.progressHeight = 10.0;
    [self.view addSubview:self.yqlWebView];
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
