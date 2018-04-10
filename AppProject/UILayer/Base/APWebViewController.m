//
//  APWebViewController.m
//  AppProject
//
//  Created by Lala on 2017/11/6.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface APWebViewController () <NJKWebViewProgressDelegate, UIWebViewDelegate>

@property (nonatomic, copy) NSString *URL;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

@end

@implementation APWebViewController

- (id)initWithURL:(NSString *)URL
{
    self = [super init];
    if (self) {
        self.URL = URL;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark Private
- (void)loadSubViews
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.scrollView.bounces = NO;
    _webView.delegate = self;
    [self addSubview:_webView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGRect barFrame = CGRectMake(0, 0, SCREEN_WIDTH, 3.0f);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.progressBarView.backgroundColor = APGlobalUI.mainColor;
    [self addSubview:_progressView];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]]];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

@end
