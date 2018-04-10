//
//  APWebViewController.h
//  AppProject
//
//  Created by Lala on 2017/11/6.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@class NJKWebViewProgressView;
@interface APWebViewController : APBaseViewController
{
    /// 进度条
    NJKWebViewProgressView *_progressView;
    /// 网页内容
    UIWebView *_webView;
}

- (id)initWithURL:(NSString *)URL;

@end
