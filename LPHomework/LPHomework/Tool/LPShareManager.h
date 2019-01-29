//
//  LPShareManager.h
//  DigitalSchool
//
//  Created by Pan on 2017/10/24.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFNetworking;

@interface LPShareManager : NSObject

/**检测网路状态**/
+ (void)netWorkStatus;

+ (LPShareManager *)shareManager;

/**
 *  封装AFN的GET请求
 *
 *  @param URLString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;

/**
 *  封装AFN的POST请求
 *
 *  @param URLString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;



///**
// *JSON方式获取数据
// *urlStr:获取数据的url地址
// *
// */
//- (void)GET:(NSString *)urlString success:(void (^)(NSDictionary *dictionary))success failure:(void (^)(NSError *error))failure;

/**
 *上传图片（数组）
 *
 *
 */
- (void)POST:(NSString *)urlString dictionary:(NSDictionary *)dic upImageArray:(NSArray *)imageArray progress:(void (^)(NSProgress * _Nonnull uploadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *   获取视频播放地址（POST）
 *
 *  @param urlString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)GetVideoUrl:(NSString *)urlString dict:(id)dict succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;




@end



