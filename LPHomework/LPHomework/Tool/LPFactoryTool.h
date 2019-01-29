//
//  LPFactoryTool.h
//  WisdomSchool_Student
//
//  Created by Pan on 2017/8/14.
//  Copyright © 2017年 HonJin. All rights reserved.
//

/** 
 *  工厂工具
 *
 *  主要用于创建一些固定规格的控件（button、label等）
 *
 */

#import <Foundation/Foundation.h>
typedef void (^MyCallback)(BOOL success,id obj);

@interface LPFactoryTool : NSObject

/** Label标签 */
+(UILabel *)initLableWithMaxWidth:(CGFloat)maxWidth
                           height:(CGFloat)height
                           string:(NSString *)string
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor
                    numberOfLines:(int)numberOfLines
                        sizfTofit:(BOOL)sizfTofit;

/** Label标签 (带行距) */
+(UILabel *)initLableWithMaxWidth:(CGFloat)maxWidth
                           height:(CGFloat)height
                           string:(NSString *)string
                             font:(UIFont *)font
                        lineSpace:(CGFloat)lineSpace
                        textColor:(UIColor *)textColor
                    numberOfLines:(int)numberOfLines
                        sizfTofit:(BOOL)sizfTofit;
///** 创建 左图片 + 右标题 标签 */
//+ (UILabel *)initButtonWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage title:(NSString *)title color:(UIColor *)color font:(UIFont *)font space:(CGFloat)space;


/** 创建头像 */
+ (UIButton *)initUserHeaderWithFrame:(CGRect)frame headString:(NSString *)headString;

/** 创建头像+姓名 按钮 */
+ (UIButton *)initUserHeaderAndNameButtonWithFrame:(CGRect)frame headString:(NSString *)headString name:(NSString *)name fontSize:(NSInteger)fontSize;

/** 创建头像 + 姓名 + 副标题 按钮 */
+ (UIButton *)initUserHeaderAndNameButtonWithFrame:(CGRect)frame headString:(NSString *)headString name:(NSString *)name fontSize:(NSInteger)fontSize subTitle:(NSString *)subTitle subFontSize:(NSInteger)subFontSize subClolr:(UIColor *)subClolr;

/** 创建 左标题 + 右图片 按钮 */
+ (UIButton *)initButtonWithFrame:(CGRect)frame leftTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font rightImage:(UIImage *)image;
+ (UIButton *)initButtonWithFrame:(CGRect)frame leftTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font rightImage:(UIImage *)image selectImage:(UIImage *)selectImage;


/** view （分割线） */
+ (UIView *)initViewWithFrame:(CGRect)frame color:(UIColor *)color;

//电话号码的判断
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+(BOOL)isWanWithNumber:(NSInteger)number;

//数字，字母，下划线的正则表达式
+(BOOL)isFuckNumberAndABC:(NSString*)userNameString;

//
///**
// *JSON方式获取数据
// *urlStr:获取数据的url地址
// *
// */
//+ (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;
// 富文本
+(NSMutableAttributedString *)myStirng:(NSString *)inputString;

@end
