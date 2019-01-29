//
//  LPFactoryTool.m
//  WisdomSchool_Student
//
//  Created by Pan on 2017/8/14.
//  Copyright © 2017年 HonJin. All rights reserved.
//

#import "LPFactoryTool.h"




@implementation LPFactoryTool

/** Label标签 */
+(UILabel *)initLableWithMaxWidth:(CGFloat)maxWidth
                           height:(CGFloat)height
                           string:(NSString *)string
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor
                    numberOfLines:(int)numberOfLines
                        sizfTofit:(BOOL)sizfTofit
{
    return [LPFactoryTool initLableWithMaxWidth:maxWidth height:height string:string font:font lineSpace:0 textColor:textColor numberOfLines:numberOfLines sizfTofit:sizfTofit];
}

/** Label标签 (带行距) */
+(UILabel *)initLableWithMaxWidth:(CGFloat)maxWidth
                           height:(CGFloat)height
                           string:(NSString *)string
                             font:(UIFont *)font
                        lineSpace:(CGFloat)lineSpace
                        textColor:(UIColor *)textColor
                    numberOfLines:(int)numberOfLines
                        sizfTofit:(BOOL)sizfTofit
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxWidth, height)];
    if ([string isKindOfClass:[NSNull class]]) {
        string = @"";
    }
    if (string.length <= 0) {
        string = @"";
    }
    if (lineSpace > 0) {
        label.attributedText = [LPCommonTool getAttributedStringWithString:string lineSpace:lineSpace];
    }else {
        label.text = string;
    }

    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.numberOfLines = numberOfLines;
    [label sizeToFit];
    if (sizfTofit) {
        if (CGRectGetWidth(label.bounds) > maxWidth) {
            label.bounds = CGRectMake(0, 0, maxWidth, CGRectGetHeight(label.bounds));
        }
    }else{
        label.bounds = CGRectMake(0, 0, maxWidth, height);
    }
    return label;
}

///** 创建 左图片 + 右标题 标签 */
//+ (UILabel *)initButtonWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage title:(NSString *)title color:(UIColor *)color font:(UIFont *)font space:(CGFloat)space {
//    
//    
//}

/** 创建头像 */
+ (UIButton *)initUserHeaderWithFrame:(CGRect)frame headString:(NSString *)headString {
    
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = frame;
    if (headString && ![headString isKindOfClass:[NSNull class]] && headString.length > 0 ) {
        headString = [headString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [headerBtn sd_setImageWithURL:[NSURL URLWithString:headString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_user"]];
    }else {
        [headerBtn setImage:[UIImage imageNamed:@"default_user"] forState:UIControlStateNormal];
    }
    
    headerBtn.layer.masksToBounds = YES;
    headerBtn.layer.cornerRadius = headerBtn.frame.size.height / 2.0;
    headerBtn.contentMode = UIViewContentModeScaleAspectFill;
    
    return headerBtn;
}

/** 创建头像+姓名 按钮 */
+ (UIButton *)initUserHeaderAndNameButtonWithFrame:(CGRect)frame headString:(NSString *)headString name:(NSString *)name fontSize:(NSInteger)fontSize {
    
    return [LPFactoryTool initUserHeaderAndNameButtonWithFrame:frame headString:headString name:name fontSize:fontSize subTitle:nil subFontSize:0 subClolr:nil];
}

/** 创建头像 + 姓名 + 副标题 按钮 */
+ (UIButton *)initUserHeaderAndNameButtonWithFrame:(CGRect)frame headString:(NSString *)headString name:(NSString *)name fontSize:(NSInteger)fontSize subTitle:(NSString *)subTitle subFontSize:(NSInteger)subFontSize subClolr:(UIColor *)subClolr {
    
    UIButton *bgButton = [[UIButton alloc] initWithFrame:frame];
    // 头像
    UIButton *headerButton = [LPFactoryTool initUserHeaderWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height) headString:headString];
    [bgButton addSubview:headerButton];
    
    if (!name) {
        return bgButton;
    }
    // 用户名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerButton.frame) + LPScalePX(15), 0, frame.size.width - CGRectGetMaxX(headerButton.frame) + LPScalePX(15), headerButton.frame.size.height * 2 / 3)];
    nameLabel.text = name;
    nameLabel.font = [UIFont systemFontOfSize:fontSize];
    [nameLabel sizeToFit];
    if (subTitle.length > 0) {
        CGPoint center = CGPointMake(nameLabel.center.x, CGRectGetMidY(headerButton.frame) - CGRectGetHeight(nameLabel.frame) / 2.0);
        nameLabel.center = center;
    }
    [bgButton addSubview:nameLabel];
    
    if (subTitle.length > 0) {
        
        // 副标题
        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame), frame.size.width - CGRectGetMaxX(headerButton.frame) + LPScalePX(15), headerButton.frame.size.height / 3)];
        subLabel.text = subTitle;
        subLabel.textColor = subClolr;
        subLabel.font = [UIFont systemFontOfSize:subFontSize];
        [subLabel sizeToFit];
        CGPoint center = CGPointMake(subLabel.center.x, CGRectGetMaxY(headerButton.frame) - CGRectGetHeight(subLabel.frame) / 2.0);
        subLabel.center = center;
        [bgButton addSubview:subLabel];
    }
    
    return bgButton;
}

/** 创建 左标题 + 右图片 按钮 */
+ (UIButton *)initButtonWithFrame:(CGRect)frame leftTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font rightImage:(UIImage *)image {
    return [self initButtonWithFrame:frame leftTitle:title color:color font:font  rightImage:image selectImage:image];
}
+ (UIButton *)initButtonWithFrame:(CGRect)frame leftTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font rightImage:(UIImage *)image selectImage:(UIImage *)selectImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    
    // 计算文字宽高
    CGFloat labelWidth = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: font}].width;

    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth)];
    
    return button;
}

/** view (分割线) */
+ (UIView *)initViewWithFrame:(CGRect)frame color:(UIColor *)color {
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    if (color) {
        line.backgroundColor = color;
    }else {
        line.backgroundColor = LPLineColor;
    }
    
    return line;
}


+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    
    if (mobileNum.length != 11) {
        return NO;
    }
    else {
        // 移动号段正则表达式
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(198)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        // 联通号段正则表达式
        NSString *CU_NUM = @"^((13[0-2])|(145)|(166)|(175)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        // 电信号段正则表达式
        NSString *CT_NUM = @"^((133)|(153)|(177)|(173)|(199)|(149)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobileNum];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobileNum];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobileNum];
        return (isMatch1 || isMatch2 || isMatch3);
    }
    return NO;
}

+(BOOL)isFuckNumberAndABC:(NSString *)userNameString{
     NSString *rightString = @"^[0-9a-zA-Z_]{1,}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rightString];
    BOOL isMatch1 = [pred1 evaluateWithObject:userNameString];
    return isMatch1;
}

+(BOOL)isWanWithNumber:(NSInteger)number{
    if (number == 0 || number == -1) {
        return NO;
    }else{
        return YES;
    }
}

+(NSMutableAttributedString *)myStirng:(NSString *)inputString{
    NSMutableAttributedString *mutableAttriteStr = [[NSMutableAttributedString alloc] initWithString:inputString];
    [mutableAttriteStr addAttribute:NSFontAttributeName value:LPFontSize(24) range:NSMakeRange(0, mutableAttriteStr.length - 1 )];
    [mutableAttriteStr addAttribute:NSFontAttributeName value:LPFontSize(12) range:NSMakeRange(mutableAttriteStr.length-1, 1)];
    [mutableAttriteStr addAttribute:NSForegroundColorAttributeName value:LPColorWithHex(0x333333) range:NSMakeRange(0, mutableAttriteStr.length - 1)];
    [mutableAttriteStr addAttribute:NSForegroundColorAttributeName value:LPColorWithHex(0x999999) range:NSMakeRange(mutableAttriteStr.length-1, 1)];
    //    inputString.attributedText = mutableAttriteStr;
    
    return mutableAttriteStr;
    
}




@end
