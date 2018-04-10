//
//  APUserKnowViewController.m
//  AppProject
//
//  Created by Lala on 2017/11/8.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APUserKnowViewController.h"

@interface APUserKnowViewController ()

@end

@implementation APUserKnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"我的-用户须知",nil);
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
    
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"instruction" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
    [_webView loadRequest:request];
    [self addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
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
