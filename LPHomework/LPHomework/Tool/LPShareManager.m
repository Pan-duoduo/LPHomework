//
//  LPShareManager.m
//  DigitalSchool
//
//  Created by Pan on 2017/10/24.
//  Copyright © 2017年 Pan. All rights reserved.
//

#import "LPShareManager.h"
#import <AFNetworking/AFNetworking.h>
#import "LPLoginOrRegisterController.h"


@implementation LPShareManager{
    
    UIAlertView * myAlertView;
    
}

/**
*  创建网络请求类的单例
*/
static LPShareManager *shareManager = nil;
+ (LPShareManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareManager == nil) {
            shareManager = [[self alloc] init];
        }
    });
    return shareManager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareManager == nil) {
            shareManager = [super allocWithZone:zone];
        }
    });
    return shareManager;
}
- (instancetype)copyWithZone:(NSZone *)zone {
    return shareManager;
}

static AFHTTPSessionManager *manager = nil;
+ (AFHTTPSessionManager *)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        manager.responseSerializer = response;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer new];
        manager.requestSerializer.timeoutInterval = LPTimeOut;
    });
    return manager;
}


#pragma mark 检测网路状态
+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //NSLog(@"网络  变化   %ld", (long)status);
        
        
    }];
}

/**
 *  封装AFN的GET请求
 *
 *  @param URLString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure {
    // 创建网络请求管理对象
    AFHTTPSessionManager *manager = [LPShareManager manager];
    URLString = [LPBaseUrl stringByAppendingString:URLString];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送网络请求(请求方式为GET)
    [manager GET:URLString parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求结果：result = %@", result);
        NSDictionary *dic = [LPCommonTool jsonToObjectWithJsonString:result];
        succeed(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure(error);
    }];
}


/**
 *  封装AFN的POST请求
 *
 *  @param URLString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure {
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //新加的，不知道为什么iOS11 会绷，，所以加了这句
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    
   // [manager.requestSerializer setValue:model.ticket forHTTPHeaderField:@"ticket"];
    //    设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  //  [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"uniqueCode"];
    // 设置请求格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    manager.requestSerializer.timeoutInterval = LPTimeOut;
    
    URLString = [LPBaseUrl stringByAppendingString:URLString];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   // NSLog(@"请求地址URL：%@", URLString);
    NSMutableDictionary * myDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [myDict setValue:[LPCommonTool readUniqueCode] forKey:@"uniqueCode"];
    [myDict setValue:[LPCommonTool readUserId] forKey:@"userId"];
    NSLog(@"拿到的字典：%@",myDict);
    
    //发送网络请求(请求方式为POST)
    [manager POST:URLString parameters:myDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
       // NSLog(@"请求结果：result = %@", result);
        succeed([LPCommonTool jsonToObjectWithJsonString:result]);
        
        if ([[LPCommonTool jsonToObjectWithJsonString:result] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary * objDict  =[LPCommonTool jsonToObjectWithJsonString:result];
            
                if ([objDict[@"flag"] integerValue] == 410) {
                    myAlertView = [[UIAlertView alloc] initWithTitle:nil message:objDict[@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil,nil];
                    [myAlertView show];
                    [self performSelector:@selector(doTime) withObject:nil afterDelay:2.0f];
                    [LPCommonTool removeUserDefaultObjectsForKeys:@[LPUSERKEY]];
                    if (![LPCommonTool isLogin:[LPCommonTool topWindowCotroller]]) {
                        return ;
                    }
                }
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"%@", error);
    }];
}

-(void)doTime{
    [myAlertView dismissWithClickedButtonIndex:0 animated:YES];
}



//#pragma mark - JSON方式获取数据
//- (void)GET:(NSString *)urlString success:(void (^)(NSDictionary *dictionary))success failure:(void (^)(NSError *error))failure {
//    
//    AFHTTPSessionManager *manager = [LPShareManager manager];
//    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
//    urlString = [LPBaseUrl stringByAppendingString:urlString];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"请求地址URL：%@", urlString);
//    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"请求结果：result = %@", result);
//        NSDictionary *dic = [LPCommonTool jsonToObjectWithJsonString:result];
//        if (success) {
//            success(dic);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

/**
 *上传图片（数组）
 *
 *
 */
- (void)POST:(NSString *)urlString dictionary:(NSDictionary *)dic upImageArray:(NSArray *)imageArray progress:(void (^)(NSProgress * _Nonnull uploadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    manager.requestSerializer.timeoutInterval = LPTimeOut;
    urlString = [LPBaseUrl stringByAppendingString:urlString];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSString * random = @"111";
//    
//    NSString * strContentType= [NSString stringWithFormat:,random];
    
    
    [manager.requestSerializer setValue:@"multipart/form-data;boundary=111" forHTTPHeaderField:@"Content-Type"];
    
    
    
//     NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fileName, @"imgData", nil];
    
    [manager POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UIImage *img in imageArray) {
            NSData *data = UIImageJPEGRepresentation(img, 0.6);
            if(data.length > 200000) {//大于200k处理
                data = UIImageJPEGRepresentation(img, 0.01);
            }
            if (!data) {
                data = UIImagePNGRepresentation(img);
            }
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"imgData" fileName:fileName mimeType:@"image/png"];
            //            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
       // NSArray * array =[self dictionaryWithJsonString:result];
        NSDictionary *dic = [LPCommonTool jsonToObjectWithJsonString:result];
        if (success) {
            success(dic);
            
        }
        NSLog(@"最后数据：%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *   获取视频播放地址（POST）
 *
 *  @param urlString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
- (void)GetVideoUrl:(NSString *)urlString dict:(id)dict succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure {
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // [manager.requestSerializer setValue:model.ticket forHTTPHeaderField:@"ticket"];
    //    设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    manager.requestSerializer.timeoutInterval = LPTimeOut;
    
//    urlString = [LPBaseUrl stringByAppendingString:urlString];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"请求地址URL：%@", urlString);
    //发送网络请求(请求方式为POST)
    [manager POST:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求结果：result = %@", result);
        succeed([LPCommonTool jsonToObjectWithJsonString:result]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
