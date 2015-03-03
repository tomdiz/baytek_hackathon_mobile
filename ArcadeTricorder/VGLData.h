//
//  VGLData.h
//  VGL
//
//  Created by Thomas DiZoglio on 3/03/14.
//  Copyright (c) 2014 Virgil Software. All rights reserved.
//

#define kVGLDataInitialTimeout  30
#define kVGLDataTimeoutIncrease 20
#define kVGLDataMaxRetries      5

#import <Foundation/Foundation.h>

@interface VGLData : NSObject <NSURLConnectionDelegate>

+ (NSString *) kapi_domain;
+ (NSString *) kapi_protocol;

+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)url;
+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)url methodName:(NSString *)method;
+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)url stringParameters:(NSDictionary *)params;
+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)url methodName:(NSString *)method stringParameters:(NSDictionary *)params;
+ (NSArray *)arrayWithContentsOfURL:(NSURL *)url methodName:(NSString *)method stringParameters:(NSDictionary *)params;

+ (NSData *)dataWithContentsOfURL:(NSURL *)url methodName:(NSString *)method stringParameters:(NSDictionary *)params;
+ (NSData *)dataWithRequest:(NSURLRequest *)request methodName:(NSString *)method stringParameters:(NSDictionary *)params;

+ (NSDictionary *)dictionaryWithContentsOfURL2:(NSURL *)url stringParameters:(NSDictionary *)params;
+ (NSData *)dataWithRequest2Format:(NSURLRequest *)request stringParameters:(NSDictionary *)params;

@end