//
//  LPBaseViewController.h
//  DigitalSchool
//
//  Created by Pan on 2017/10/23.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPSearchView;

@interface LPBaseViewController : UIViewController

@property (nonatomic, assign)BOOL presentVC;
@property (nonatomic, strong) UIButton *rightBarButton;         // 导航栏右按钮
@property (nonatomic, strong) UIButton *leftBackButton;         // 左导航栏
@property (nonatomic, strong) LPSearchView *searchView;         // 搜索栏

@property (nonatomic, assign) BOOL vcCanScroll;                 // 滑动判定


/** 图片初始化有导航栏按钮 */
- (void)addRightBarButtonItemWithImage:(NSString *)imageName;
- (void)addRightBarButtonItemWithImage:(NSString *)imageName selectImage:(NSString *)selectImage;
- (void)addRightBarButtonItemWithImage:(NSString *)imageName selectImage:(NSString *)selectImage isSelect:(BOOL)isSelect;
/** 文字初始化有导航栏按钮 */
- (void)addRightBarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)color;
- (void)addRightBarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)color selectColor:(UIColor *)selectColor;
/** 添加导航栏搜索框(isEdit:是否可编辑) */
- (void)addSearchViewWithPlaceholder:(NSString *)placeholder isEdit:(BOOL)isEdit;

/** 返回 */
- (void)pushBackAction:(id)sender;
/** 右按钮点击 */
- (void)rightBarButtonItemClick:(UIButton *)sender;
/** 搜索框点击 */
- (void)searchClick:(UITapGestureRecognizer *)tap;

/** 滑动始终保持在顶部 */
- (void)keepTop;


@end
