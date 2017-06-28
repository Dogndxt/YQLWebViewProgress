# YQLWebViewProgress
网页进度条显示，WebViewProgress




只需六行代码，快速让你的网页具备进度条显示的效果


导入头文件：

	#import "YQLWebView.h"

使用文件和设置相关参数：

    YQLWebView *webView = [[YQLWebView alloc] initWithFrame:self.view.bounds];
    webView.urlStr = @"https://google.com/";
    webView.progressColor = [UIColor redColor];
    webView.progressHeight = 10.0;
    [self.view addSubview:webView];