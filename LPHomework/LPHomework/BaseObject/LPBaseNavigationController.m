//
//  LPBaseNavigationController.m
//  DigitalSchool
//
//  Created by Pan on 2017/10/23.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import "LPBaseNavigationController.h"

@interface LPBaseNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation LPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify_self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        @strongify_self;
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate =  self;
    }
    
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSDictionary *attributes;
    if(IOS8_OR_LATER)
    {
        self.navigationBar.translucent = NO;
        
        self.navigationBar.tintColor = [UIColor blackColor];
        attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                      LPColorWithHex(0x6a6a6a), NSForegroundColorAttributeName,
                      LPFontBoldSize(17), NSFontAttributeName,nil];
    }
    else
    {
        self.navigationBar.tintColor = [UIColor blackColor];
        attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                      LPColorWithHex(0x6a6a6a), NSForegroundColorAttributeName,
                      LPFontBoldSize(17), NSFontAttributeName,nil];
    }
    [self.navigationBar setTitleTextAttributes:attributes];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    self.navigationBar.backgroundColor = LPNavigationColor;
//    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:DSAppTintColor] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.shadowImage = [[UIImage alloc] init];
}


#pragma maek =========== delegate ==============
//侧滑代理
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer   *)gestureRecognizer{
    if (self.childViewControllers.count == 1) {//只有非更控制器才有滑动
        return NO;
    }
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated == YES ){
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]&& animated == YES ){
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
