//
//  LPBaseViewController.m
//  DigitalSchool
//
//  Created by Pan on 2017/10/23.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import "LPBaseViewController.h"
#import "LPSearchView.h"

@interface LPBaseViewController ()


@end

@implementation LPBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    // backButton   返回按钮
    if (self.navigationController.viewControllers.count > 1 || self.presentVC) {
        _leftBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBackButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_leftBackButton sizeToFit];
        CGRect rect = _leftBackButton.frame;
        rect.size.height = 44;
        _leftBackButton.frame = rect;
        [_leftBackButton addTarget:self action:@selector(pushBackAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBackButton];
    }
    

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 只能这么写，禁用 self.navigationController.navigationBar.hidden = NO 有时不生效
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 页面离开浏览统计
    self.navigationController.navigationBarHidden = NO;
}

/** 图片初始化有导航栏按钮 */
- (void)addRightBarButtonItemWithImage:(NSString *)imageName {
    [self addRightBarButtonItemWithImage:imageName selectImage:nil];
    
}
- (void)addRightBarButtonItemWithImage:(NSString *)imageName selectImage:(NSString *)selectImage {
    [self addRightBarButtonItemWithImage:imageName selectImage:selectImage isSelect:NO];
}

- (void)addRightBarButtonItemWithImage:(NSString *)imageName selectImage:(NSString *)selectImage isSelect:(BOOL)isSelect {
    // 右按钮
    _rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBarButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selectImage && selectImage.length > 0) {
        [_rightBarButton setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }
    if (isSelect) {
        _rightBarButton.selected = YES;
    }
    [_rightBarButton sizeToFit];
    _rightBarButton.frame = CGRectMake(0, 0, CGRectGetWidth(_rightBarButton.frame) + LPScalePX(20), 44);
    // 注：图片右居中对齐
//    _rightBarButton.contentVerticalAlignment = NSTextAlignmentCenter;
    _rightBarButton.contentHorizontalAlignment = NSTextAlignmentRight;
    [_rightBarButton addTarget:self action:@selector(rightBarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];
}

- (void)addSearchViewWithPlaceholder:(NSString *)placeholder isEdit:(BOOL)isEdit {
    
    // 搜索框
    _searchView = [[LPSearchView alloc] initWithFrame:CGRectMake(0, 0, LPScreen_W, LPScalePX(60)) placeholder:placeholder isEdit:isEdit];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick:)];
    [_searchView addGestureRecognizer:tap];
    
    self.navigationItem.titleView = _searchView;
    
    // 左右边距处理；如果没有左右边按钮，搜索框显示距离左右边太近，做个假的占位
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    }
    if (!self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}



/** 文字初始化有导航栏按钮 */
- (void)addRightBarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)color {
    [self addRightBarButtonItemWithTitle:title titleColor:color selectColor:nil];
}

- (void)addRightBarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)color selectColor:(UIColor *)selectColor {
    // 右按钮
    _rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBarButton setTitle:title forState:UIControlStateNormal];
    _rightBarButton.titleLabel.font = LPFontSize(14);
    if (color) {
        [_rightBarButton setTitleColor:color forState:UIControlStateNormal];
    }else {
        [_rightBarButton setTitleColor:LPColorWithHex(0x4a4a4a) forState:UIControlStateNormal];
    }
    if (selectColor) {
        [_rightBarButton setTitleColor:selectColor forState:UIControlStateSelected];
    }
    [_rightBarButton sizeToFit];
    [_rightBarButton addTarget:self action:@selector(rightBarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];
}

- (void)pushBackAction:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (![self.navigationController popViewControllerAnimated:YES]) {
        
        if (self.navigationController) {
            // 添加动画
            //创建动画
            CATransition *animation = [CATransition animation];
            //设置运动轨迹的速度（先慢后快）
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            //设置动画类型为立方体动画
            animation.type = kCATransitionPush;
            //设置运动的方向
            animation.subtype = kCATransitionFromLeft;
            //设置动画时长
            animation.duration = 0.28f;
            [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
            [self.navigationController dismissViewControllerAnimated:NO completion:^{
                ;
            }];
        }
        [self dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    }
}

- (void)rightBarButtonItemClick:(UIButton *)sender {
    
}

- (void)searchClick:(UITapGestureRecognizer *)tap {
    
}

/** 滑动始终保持在顶部 */
- (void)keepTop {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
