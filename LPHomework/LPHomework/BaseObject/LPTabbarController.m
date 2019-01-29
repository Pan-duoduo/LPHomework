//
//  TabbarController.m
//  DigitalSchool
//
//  Created by Pan on 2017/10/23.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import "LPTabbarController.h"
#import "LPHomeViewController.h"
#import "LPMessageController.h"
#import "LPClassController.h"
#import "LPMineController.h"
//#import "TrajectoryViewController.h"

@interface LPTabbarController ()

@end

@implementation LPTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMainTabbar];
}

- (void)addMainTabbar {
    
    // 设置白色背景
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
        
    // 1.首页
    self.homeVC = [[LPHomeViewController alloc] init];
    UIImage *homeImage =[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeImageA = [[UIImage imageNamed:@"tabbar_home_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.homeVC.title =@"首页";
    self.homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:homeImage selectedImage:homeImageA];
    // 标题文字偏移
    [self.homeVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -LPScalePX(5))];
    LPBaseNavigationController *homeNav = [[LPBaseNavigationController alloc] initWithRootViewController:self.homeVC];
    //homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:homeImage selectedImage:homeImageA];
    
    
    // 3.机构首页 (特殊按钮)
    LPMessageController *messageVC = [[LPMessageController alloc] init];
    UIImage *institutionImage =[[UIImage imageNamed:@"tabbar_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *institutionImageA = [[UIImage imageNamed:@"tabbar_message_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageVC.title = @"消息";
    messageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:institutionImage selectedImage:institutionImageA];
    [messageVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -LPScalePX(5))];
    LPBaseNavigationController *institutionNav = [[LPBaseNavigationController alloc] initWithRootViewController:messageVC];
    
    //轨迹
    LPClassController * classVC = [[LPClassController alloc]init];
    UIImage *trajectoryImage =[[UIImage imageNamed:@"tabbar_class"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *trajectoryImageA = [[UIImage imageNamed:@"tabbar_class"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    classVC.title =@"班级";
    classVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"班级" image:trajectoryImage selectedImage:trajectoryImageA];
    [classVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -LPScalePX(5))];
    LPBaseNavigationController *trajectoryNav = [[LPBaseNavigationController alloc] initWithRootViewController:classVC];
    
    
    // 4.问答页
//    LPQuestionAnswerController *questionVC = [[LPQuestionAnswerController alloc] init];
//    UIImage *questionImage =[[UIImage imageNamed:@"questionAnswer"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *questionImageA = [[UIImage imageNamed:@"questionAnswer_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    questionVC.title =@"问答";
//    questionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"问答" image:questionImage selectedImage:questionImageA];
//    [questionVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -LPScalePX(5))];
//    LPBaseNavigationController *questionNav = [[LPBaseNavigationController alloc] initWithRootViewController:questionVC];
   // questionNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"问答" image:questionImage selectedImage:questionImageA];
   
    // 5.我的页面
    LPMineController *mineVC = [[LPMineController alloc] init];
    UIImage *mineImage =[[UIImage imageNamed:@"tabbar_mine"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mineImageA = [[UIImage imageNamed:@"tabbar_mine_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineVC.title =@"我的";
    mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:mineImage selectedImage:mineImageA];
    [mineVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -LPScalePX(5))];
    LPBaseNavigationController *mineNav = [[LPBaseNavigationController alloc] initWithRootViewController:mineVC];
    
    //默认字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:LPColorWithHex(0x595959)} forState:UIControlStateNormal];
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:LPAppColor} forState:UIControlStateSelected];
    self.viewControllers = @[homeNav, institutionNav, trajectoryNav, mineNav];
    
//    // bottomBar 分割线
//    for (int i = 0; i < 4; i++) {
//        UIView *line = [LPFactoryTool initViewWithFrame:CGRectMake(LPScreen_W / 5.0 + LPScreen_W / 5.0 * i, LPScreen_H -  (44 + LPScalePX(40)) / 2.0, LPScalePX(1), LPScalePX(40)) color:LPColorWithHex(0xe6e9e9)];
//        [self.tabBarController.view addSubview:line];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
