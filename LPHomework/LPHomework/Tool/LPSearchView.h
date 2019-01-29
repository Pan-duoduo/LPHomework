//
//  LPSearchView.h
//  DigitalSchool
//
//  Created by Pan on 2017/11/15.
//  Copyright © 2017年 Pan. All rights reserved.
//

/** 自定制搜索框 */

#import <UIKit/UIKit.h>

@interface LPSearchView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
//@property (nonatomic, strong) UIImage *leftImage;
//@property (nonatomic, strong) UIImage *rightImage;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) CGFloat space;            // 输入框左边距
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, assign) BOOL edit;            // 是否允许输入（默认YES!）


/** 初始化-默认样式
 placeholder:   占位符
 isEdit:        是否可输入编辑
 */
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder isEdit:(BOOL)isEdit;
- (void)addLeftViewWithSpace:(CGFloat)space;                                // 添加左侧按钮（space：图标间距）
- (void)addRightViewWithSpace:(CGFloat)space;                               // 添加右侧按钮（space：图标间距）

//typedef void (^TextFieldViewBlock)();
//@property (nonatomic, copy) TextFieldViewBlock textFieldBlock;    // 视图回调


//- (instancetype)initWithFrame:(CGRect)frame

@end
