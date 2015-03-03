//
//  VGLData.m
//  VGL
//
//  Created by Thomas DiZoglio on 3/03/14.
//  Copyright (c) 2014 Virgil Software. All rights reserved.
//

#import "VGLData.h"
#include "TargetConditionals.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation VGLData

// START CONSTANT METHODS
+ (NSString *) kapi_domain {
    return @"localhost:3000";
    
    return @"pcqx.t.proxylocal.com";
    //return @"192.168.102.31:3000";
}

+ (NSString *) kapi_protocol {
    return @"http";
}

// END CONSTANT METHODS

+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)url {
    return [self dictionaryWithContentsOfURL:url methodName:@"GET" stringParameters:nil];
}

+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)url methodName:(NSString *)method{
    return [self dictionaryWithContentsOfURL:url methodName:method stringParameters:nil];
}

+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)url stringParameters:(NSDictionary *)params {
    return [self dictionaryWithContentsOfURL:url methodName:@"GET" stringParameters:params];
}

+ (NSDictionary *)dictionaryWithContentsOfURL2:(NSURL *)url stringParameters:(NSDictionary *)params {
    NSData *data = [self dataWithRequest2Format:[NSURLRequest requestWithURL:url]  stringParameters:params];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
}

+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)url methodName:(NSString *)method stringParameters:(NSDictionary *)params{
    NSData *data = [self dataWithContentsOfURL:url methodName:method stringParameters:params];
    
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
    } else {
        return [NSDictionary dictionary];
    }
}

+ (NSArray *)arrayWithContentsOfURL:(NSURL *)url methodName:(NSString *)method stringParameters:(NSDictionary *)params {
    
    NSData *data = [self dataWithContentsOfURL:url methodName:method stringParameters:params];
    
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
    } else {
        return [NSArray array];
    }
}

+ (NSData *)dataWithContentsOfURL:(NSURL *)url methodName:(NSString *)method stringParameters:(NSDictionary *)params{
    return [self dataWithRequest:[NSURLRequest requestWithURL:url]  methodName:method stringParameters:params];
}

// Fetches data with a fall-off-based retry interval
+ (NSData *)dataWithRequest:(NSURLRequest *)request methodName:(NSString *)method stringParameters:(NSDictionary *)params{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    int                 retryAttempt    = 0;
    NSTimeInterval      timeout         = kVGLDataInitialTimeout;
    NSData              *data           = nil;
    
    [mutableRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [mutableRequest setHTTPMethod:method];
    [mutableRequest setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
    if (params != nil) {
        NSLog(@"Params: %@", params);
        
        // =========
        // In body data for the 'application/x-www-form-urlencoded' content type,
        // form fields are separated by an ampersand. Note the absence of a
        // leading ampersand.
        
        NSString *bodyData = nil;;
        
        for (NSString *param_key in params) {
            if (bodyData == nil) {
                bodyData = [NSString stringWithFormat:@"%@=%@", param_key, [params objectForKey:param_key]];
            } else {
                bodyData = [NSString stringWithFormat:@"%@&%@=%@", bodyData, param_key, [params objectForKey:param_key]];
            }
        }
        
        if ([method isEqual: @"GET"] || [method isEqual: @"POST"]) {
            // If it's just a GET method, simply add the parameters to the end of the URL string.
            NSString *original_url = [[mutableRequest URL] absoluteString];
            NSString *url_string;
            if (bodyData == nil)
                url_string = [NSString stringWithFormat:@"%@", original_url];
            else
                url_string = [NSString stringWithFormat:@"%@?%@", original_url, bodyData];
            
            NSURL *url =  [NSURL URLWithString:[url_string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
            
            NSLog(@"URL: %@", url_string);
            
            [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [mutableRequest setURL:url];
            
        } else {
            // Set the request's content type to application/x-www-form-urlencoded
            
            [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            
            // Designate the request a POST request and specify its body data
            [mutableRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]]];
        }
    }
    
    while (data == nil) {
        [mutableRequest setTimeoutInterval:timeout];
        
        //NSLog(@":Mutable Request: %@", mutableRequest);
        
        NSError *error = nil;
        
        NSURLResponse *response;
        data = [NSURLConnection sendSynchronousRequest:mutableRequest returningResponse:&response error:&error];
        
        NSHTTPURLResponse *httpResponse;
        httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
        
        if (!data) {
            retryAttempt++;
            timeout += kVGLDataTimeoutIncrease;
            
            if (retryAttempt == kVGLDataMaxRetries) {
                //NSLog(@"Error processing request: %@", error);
                
                @throw [NSException exceptionWithName:@"VGLDataTimeoutException" reason:[NSString stringWithFormat:@"Data could not be fetched from URL (%@) within %d attempts.", [request.URL absoluteString], kVGLDataMaxRetries] userInfo:nil];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"VGLData/RetryAttempt" object:[NSNumber numberWithInt:retryAttempt]];
        }
    }
    
    mutableRequest = nil;
    
    return data;
}

// Fetches data with a fall-off-based retry interval
+ (NSData *)dataWithRequest2Format:(NSURLRequest *)request stringParameters:(NSDictionary *)params{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    int                 retryAttempt    = 0;
    NSTimeInterval      timeout         = kVGLDataInitialTimeout;
    NSData              *data           = nil;
    
    [mutableRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
    if (params != nil) {
        NSLog(@"Params: %@", params);
        
        // =========
        // In body data for the 'application/x-www-form-urlencoded' content type,
        // form fields are separated by an ampersand. Note the absence of a
        // leading ampersand.
        
        NSString *bodyData = nil;
        BOOL bFinish = NO;
        
        for (NSString *param_key in params) {
            bFinish = YES;
            if (bodyData == nil) {
                bodyData = [NSString stringWithFormat:@"{ \"%@\":\"%@\"", param_key, [params objectForKey:param_key]];
            } else {
                bodyData = [NSString stringWithFormat:@"%@, \"%@\":\"%@\"", bodyData, param_key, [params objectForKey:param_key]];
            }
        }
        if (bFinish == YES)
            bodyData = [NSString stringWithFormat:@"%@ }", bodyData];
        
        // Set the request's content type to application/x-www-form-urlencoded
        
        [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSLog(@"bodyData = %@", bodyData);
        
        // Designate the request a POST request and specify its body data
        [mutableRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]]];
    }
    
    while (data == nil) {
        [mutableRequest setTimeoutInterval:timeout];
        
        NSLog(@":Mutable Request: %@", mutableRequest);
        
        NSError *error = nil;
        
        NSURLResponse *response;
        data = [NSURLConnection sendSynchronousRequest:mutableRequest returningResponse:&response error:&error];
        
        NSHTTPURLResponse *httpResponse;
        httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"HTTP Response Headers %@", [httpResponse allHeaderFields]);
        
        if (!data) {
            retryAttempt++;
            timeout += kVGLDataTimeoutIncrease;
            
            if (retryAttempt == kVGLDataMaxRetries) {
                //NSLog(@"Error processing request: %@", error);
                
                @throw [NSException exceptionWithName:@"VGLDataTimeoutException" reason:[NSString stringWithFormat:@"Data could not be fetched from URL (%@) within %d attempts.", [request.URL absoluteString], kVGLDataMaxRetries] userInfo:nil];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"VGLData/RetryAttempt" object:[NSNumber numberWithInt:retryAttempt]];
        }
    }
    
    mutableRequest = nil;
    
    return data;
}

@end
