//
//  LPWebViewController.m
//  DigitalSchool
//
//  Created by Pan on 2018/4/11.
//  Copyright © 2018年 Pan. All rights reserved.
//

/** H5页面(新) */

#import "LPWebViewController.h"
#import <WebKit/WebKit.h>

//#import "LPCourseDetailViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface LPWebViewController ()<WKUIDelegate,WKScriptMessageHandler, WKNavigationDelegate, UIScrollViewDelegate>

@property (nonatomic,strong)  WKWebView *webview;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic,assign)CGFloat isIphoneX;

@end

@implementation LPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMainView];

    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


#pragma mark 移除观察者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:_webview];
    [self.webview removeObserver:self forKeyPath:@"title"];
}

- (void)addMainView {
    
    if (self.share) {
        [self addRightBarButtonItemWithImage:@"share_courseDetail_a"];
    }
    
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    [configuration.userContentController addScriptMessageHandler:self name:@"openCourseDetail"];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    configuration.preferences = preferences;
    if (IS_IPHONE_X) {
        self.isIphoneX = 44;
    }else{
        self.isIphoneX = 0;
    }
    
    
    _webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, LPScreen_W, LPScreen_H - 64 - self.isIphoneX) configuration:configuration];
    
    if(@available(iOS 11.0, *)) {
        _webview.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    }
    
    _webview.navigationDelegate = self;
    _webview.UIDelegate = self;
    _webview.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webview];
    
    
    if (!self.url || self.url.length <= 0) {
        return;
    }
    
    // 编码，防止字符串有中文等导致错误
    self.url = [self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *webUrl = [NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:webUrl];
    
    request.timeoutInterval = LPTimeOut;
    // ** 注：容错处理，无效URL避免崩溃
    if ([[UIApplication sharedApplication] canOpenURL:webUrl]) {
        [_webview loadRequest:request];
    }

    // 监听web标题  
    [_webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    
}

#pragma ***************** KVO标题监听代理 ************************
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"] && object == _webview){
        self.title = _webview.title;
    }
}



#pragma mark ************************ web代理 ************************
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"加载完成");
    if ([_webview subviews] && _offsetY > 0) {
        // 延迟执行。才生效。关闭滑动，避免手势冲突.
        _webview.scrollView.scrollEnabled = NO;
        [self performSelector:@selector(scrollToOffsetY) withObject:nil afterDelay:1.0];
    }
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"加载失败");
}

/** 跳转记录偏移 */
- (void)scrollToOffsetY {
    NSLog(@"滚动到页面偏移量：%lf", _offsetY);
    [_webview.scrollView setContentOffset:CGPointMake(0, _offsetY) animated:NO];
    _webview.scrollView.scrollEnabled = YES;
}


#pragma mark - WKScriptMessageHandler
/*
 1、js调用原生的方法就会走这个方法
 2、message参数里面有2个参数我们比较有用，name和body，
 2.1 :其中name就是之前已经通过addScriptMessageHandler:name:方法注入的js名称
 2.2 :其中body就是我们传递的参数了，我在js端传入的是一个字典，所以取出来也是字典，字典里面包含原生方法名以及被点击图片的url
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    // test
    //    [SVProgressHUD showErrorWithStatus:message.body];
    NSLog(@"收到的东西：%@", message.body);
    NSString *messageName = [NSString stringWithFormat:@"%@", message.name];
    NSString *messageBody = [NSString stringWithFormat:@"%@", message.body];
    
    if ([messageName isEqualToString:@"openCourseDetail"]) {
        // 打开课程详情
//        NSDictionary *dic = [LPCommonTool jsonToObjectWithJsonString:messageBody];
//        LPCourseDetailViewController *detailVC = [[LPCourseDetailViewController alloc] init];
////        detailVC.titleString = [NSString stringWithFormat:@"%@", dic[@"commodityName"]];
////        // 操蛋，想麻仁，SB东西
////        detailVC.flagType = [dic[@"liveFlag"] integerValue] == 1 ? 0 : 1;
//        detailVC.commodityId = (NSNumber *)dic[@"commodityId"];
//      //  detailVC.classtypeId = [dic[@"classTypeId"] integerValue];
//        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - webViewDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
}


#pragma mark ************************ 点击区域 ************************
-(void)rightBarButtonItemClick:(UIButton *)sender {
    
//    [LPShareKit shareWithTitle:self.titleStr summary:self.shareDesc image:self.shareImage urlString:self.shareUrl ? self.shareUrl : self.url block:^(shareType type) {
//
//    }];
}

-(void)pushBackAction:(id)sender{
    if (_webview.canGoBack == YES) {
        [_webview goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
