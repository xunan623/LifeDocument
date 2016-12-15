//
//  XNHomeDetailViewController.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/15.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNHomeDetailViewController.h"
#import <MBProgressHUD.h>

@interface XNHomeDetailViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation XNHomeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航
    [self setupNav];
    
    // 创建UIWebView
    [self setupWebView];
}

- (void)setupWebView
{
    UIWebView *webView= [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.model.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    self.webView = webView;
}

/**
 *  设置导航
 */
- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];

}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

}


























@end
