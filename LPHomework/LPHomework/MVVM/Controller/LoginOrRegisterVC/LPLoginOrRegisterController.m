//
//  LPLogin0rRegisterController.m
//  LPHomework
//
//  Created by 刘潘 on 2019/1/28.
//  Copyright © 2019年 LPHomework. All rights reserved.
//

#import "LPLoginOrRegisterController.h"
#import "LPLoginOrRegisterVM.h"
#import "LPLoginOrRegisterView.h"


@interface LPLoginOrRegisterController ()

@property (nonatomic, strong) LPLoginOrRegisterVM *loginVM;
@property (nonatomic, strong) LPLoginOrRegisterView *loginView;



@end

@implementation LPLoginOrRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (LPLoginOrRegisterVM *)loginVM
{
    if (!_loginVM) {
        _loginVM = [[LPLoginOrRegisterVM alloc] init];
    }
    return _loginVM;
}

- (LPLoginOrRegisterView *)loginView {
    if (!_loginView) {
        _loginView = [[LPLoginOrRegisterView alloc] init];
    }
    return _loginView;
}

- (void)setUp
{
    [self.view addSubview:self.loginView];
    
    RAC(self.loginVM, account) = _loginView.acountTF.rac_textSignal;
    RAC(self.loginVM, password) = _loginView.passworkTF.rac_textSignal;
    // 订阅登录按钮是否可点击
    RAC(_loginView.loginButton, enabled) = self.loginVM.btnEnableSignal;
    
    // 登录按钮点击事件绑定到VM的command中
    @weakify_self;
    [[_loginView.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify_self;
        [self.loginVM.loginCommand execute:@{@"account": self.loginView.acountTF.text, @"password": self.loginView.passworkTF.text}];
    }];
    
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
