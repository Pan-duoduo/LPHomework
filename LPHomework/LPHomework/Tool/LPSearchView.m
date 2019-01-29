//
//  LPSearchView.m
//  DigitalSchool
//
//  Created by Pan on 2017/11/15.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import "LPSearchView.h"

@implementation LPSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    
   return [self initWithFrame:frame placeholder:nil isEdit:YES];
}

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder isEdit:(BOOL)isEdit {
    if (self = [super initWithFrame:frame]) {
        _placeholder = placeholder;
        _edit = isEdit;
        [self addMainView];
        [self setDefaultStyle];
    }
    return self;
}

- (void)addMainView {
    
    self.backgroundColor = LPColorWithHex(0xe2e2e2);
    self.layer.cornerRadius = LPScalePX(8);
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled = YES;
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.textField.backgroundColor = [UIColor clearColor];
    self.textField.delegate = self;
    self.textField.userInteractionEnabled = self.edit;
    
    [self addSubview:self.textField];
}

- (void)setDefaultStyle {
    
    self.placeholder = self.placeholder;
    self.textFont = LPFontSize(12);
    self.backgroundColor = LPColorWithHex(0xf1f1f1);
    self.cornerRadius = self.frame.size.height / 2.0;
    self.textColor = LPColorWithHex(0x4a4a4a);
    [self addLeftViewWithSpace:LPScalePX(20)];
}

- (void)setSpace:(CGFloat)space {
    _space = space;
    self.textField.frame = CGRectMake(space, 0, self.frame.size.width - space, self.frame.size.height);
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    if (!placeholder) {
        placeholder = @"";
    }
    // 设置占位符、颜色
    // 方法一：attributedPlaceholder属性修改颜色
    NSAttributedString *placeholderAttr = [[NSAttributedString alloc] initWithString:placeholder
                                                                          attributes:@{
                                                                                       NSForegroundColorAttributeName: LPColorWithHex(0x999999),
                                                                                       NSFontAttributeName: LPFontSize(14)
                                                                                       }];
    self.textField.attributedPlaceholder = placeholderAttr;
    
    // 方法二：KVC修改颜色（先赋值）
//    self.textField.placeholder = placeholder;
//    [self.textField setValue:LPColorWithHex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}
- (void)setTextColor:(UIColor *)textColor {
    self.textField.textColor = textColor;
}
- (void)setTextFont:(UIFont *)textFont {
    self.textField.font = textFont;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if ([LPCommonTool isNineKeyBoard:string]) {
//        return YES;
//    }else{
//        /**
//         更新日期：2018.1.26
//         更新内容：去掉表情输入限制，所有的特殊字符，都可以输入
//         */
//
////        if ([LPCommonTool hasEmoji:string] || [LPCommonTool stringContainsEmoji:string]) {
////            [SVProgressHUD showErrorWithStatus:@"不能输入表情哟"];
////            return NO;
////        }
//    }
    
    /** 正则表达式判断输入（中文、英文、数字、符号） */
    if (![LPCommonTool predicateString:string]) {
        NSLog(@"不能输入表情哟");
//        [SVProgressHUD showErrorWithStatus:@"不能输入表情哟"];
        return NO;
    }
    
    return YES;
}


- (void)addLeftViewWithSpace:(CGFloat)space {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    // 请先赋值space 再设置图片
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width + space * 2, self.frame.size.height)];
    imageView.center = CGPointMake(bgView.frame.size.width / 2.0, self.frame.size.height / 2.0);
    [bgView addSubview:imageView];
    self.textField.leftView = bgView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)addRightViewWithSpace:(CGFloat)space {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    // 请先赋值space 再设置图片
    imageView.center = CGPointMake(imageView.frame.size.width / 2.0, self.frame.size.height / 2.0);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width + space * 2, self.frame.size.height)];
    [bgView addSubview:imageView];
    self.textField.rightView = bgView;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
}




@end
