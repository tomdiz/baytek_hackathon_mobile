//
//  Friends.m
//  MTQ
//
//  Created by Thomas DiZoglio on 7/18/14.
//  Copyright (c) 2014 Thomas DiZoglio. All rights reserved.
//

#import "Friends.h"
#import "MTQAppDelegate.h"
#import "NSManagedObject+FetchWithEntityNameAndPredicate.h"
#import "NSManagedObjectContext+SyncCollections.h"
#import "MTQData.h"
#import "MTQConstants.h"
#import "StringUtil.h"

@implementation Friends

@dynamic emailAddress;
@dynamic layer_id;
@dynamic layer_token;

+ (void)postFriendEmailAddressesWithCompletion:(void (^)(BOOL success))completion withEmailAddrString:(NSString *)emailAddrString andWithHUD:(MBProgressHUD *)hud
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        MTQAppDelegate *iDelegate = (MTQAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        // This thread will have it's own managed object context to prevent deadlocking with other core data requests
        NSManagedObjectContext *updateManagedObjectContext = [[NSManagedObjectContext alloc] init];
        updateManagedObjectContext.persistentStoreCoordinator = iDelegate.persistentStoreCoordinator;
        
        if (hud != nil) {
            [hud setProgress:90/360.0];
        }

        NSMutableDictionary *params  = [[NSMutableDictionary alloc] init];

        NSString *s_email = [[NSUserDefaults standardUserDefaults] objectForKey:@"s_email_address"];
        if ([s_email isEqualToString:@""]) {
            
            // Not signed up yet so stop sync'ing until user does so
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
            return;
        }
        [params setValue:s_email forKey:@"s_email"];
        
        NSString *isBusiness = [[NSUserDefaults standardUserDefaults] objectForKey:@"is_business"];
        if ([isBusiness isEqualToString:@"YES"])
            [params setValue:@"yes" forKey:@"isBusiness"];
        else
            [params setValue:@"no" forKey:@"isBusiness"];

        [params setValue:emailAddrString forKey:@"friend_emails"];
        
        NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
        NSString
        *gid = CRGID(),
        *appVersion = [[mainBundle infoDictionary] objectForKey:@"CFBundleVersion"];
        if(!appVersion) appVersion = @"NA";
        NSString
        *signatureHash = [NSString stringWithFormat:@"%@:%@:%@:%@", MTQ_SERVER_TOKEN, gid, MTQ_SERVER_SECRET, appVersion],
        *signature = [StringUtil hexDigestForString:signatureHash];
        
        [params setValue:MTQ_SERVER_TOKEN forKey:@"token"];
        [params setValue:signature forKey:@"signature"];
        [params setValue:appVersion forKey:@"appversion"];
        [params setValue:gid forKey:@"gid"];

        NSLog(@"params = %@", params);

        NSString *path = [NSString stringWithFormat:@"%@://%@/friends", MTQData.kapi_protocol, MTQData.kapi_domain];
        
        NSLog(@"Invite Friends Path: %@", path);
        NSDictionary *result;
        @try {
            result  = [MTQData dictionaryWithContentsOfURL:[NSURL URLWithString:path] methodName:@"POST" stringParameters:params];
        }
        @catch (NSException *exception) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO);
            });
            return;
        }

        NSLog(@"result = %@", result);

        if (hud != nil) {
            [hud setProgress:180/360.0];
        }
/*
        // Remove all Friends so don't do again
        NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
        [fetch setEntity:[NSEntityDescription entityForName:@"Friends" inManagedObjectContext:updateManagedObjectContext]];
        NSArray *removeClientsArray = [updateManagedObjectContext executeFetchRequest:fetch error:nil];
        for (id newClients in removeClientsArray)
            [updateManagedObjectContext deleteObject:newClients];
*/
        // Persist the data store
        [updateManagedObjectContext save:nil];
        
        if (hud != nil) {
            [hud setProgress:270/360.0];
        }
        
        // Complete
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(YES);
        });
    });
}

+ (void)getFriendEmailAddressesSignedUpWithCompletion:(void (^)(BOOL success))completion andWithHUD:(MBProgressHUD *)hud {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        MTQAppDelegate *iDelegate = (MTQAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        // This thread will have it's own managed object context to prevent deadlocking with other core data requests
        NSManagedObjectContext *updateManagedObjectContext = [[NSManagedObjectContext alloc] init];
        updateManagedObjectContext.persistentStoreCoordinator = iDelegate.persistentStoreCoordinator;
        
        if (hud != nil) {
            [hud setProgress:45/360.0];
        }
        
        NSMutableDictionary *params  = [[NSMutableDictionary alloc] init];
 
        NSString *s_email = [[NSUserDefaults standardUserDefaults] objectForKey:@"s_email_address"];
        if ([s_email isEqualToString:@""]) {
            
            // Not signed up yet so stop sync'ing until user does so
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
            return;
        }
        [params setValue:s_email forKey:@"s_email"];
        
        NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
        NSString
        *gid = CRGID(),
        *appVersion = [[mainBundle infoDictionary] objectForKey:@"CFBundleVersion"];
        if(!appVersion) appVersion = @"NA";
        NSString
        *signatureHash = [NSString stringWithFormat:@"%@:%@:%@:%@", MTQ_SERVER_TOKEN, gid, MTQ_SERVER_SECRET, appVersion],
        *signature = [StringUtil hexDigestForString:signatureHash];
        
        [params setValue:MTQ_SERVER_TOKEN forKey:@"token"];
        [params setValue:signature forKey:@"signature"];
        [params setValue:appVersion forKey:@"appversion"];
        [params setValue:gid forKey:@"gid"];

        NSLog(@"params = %@", params);
        
        //NSString *path = [NSString stringWithFormat:@"%@://%@:3000/friends", MTQData.kapi_protocol, MTQData.kapi_domain];
        NSString *path = [NSString stringWithFormat:@"%@://%@/friends", MTQData.kapi_protocol, MTQData.kapi_domain];
        
        NSLog(@"GET Friends Path: %@", path);
        NSDictionary *result;
        @try {
            result  = [MTQData dictionaryWithContentsOfURL:[NSURL URLWithString:path] methodName:@"GET" stringParameters:params];
        }
        @catch (NSException *exception) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
            return;
        }
        
        NSLog(@"result = %@", result);

        if (hud != nil) {
            [hud setProgress:100/360.0];
        }
        
        //NSString *success = [result objectForKey:@"status"];
        NSString *jsonArray = [result objectForKey:@"listofusers"];
        NSArray *data = [NSJSONSerialization JSONObjectWithData:[jsonArray dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        NSLog(@"data = %@", data);
        
        if ([data isKindOfClass:[NSArray class]]) {
            
            // Remove all friends so don't do again
            NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
            [fetch setEntity:[NSEntityDescription entityForName:@"Friends" inManagedObjectContext:updateManagedObjectContext]];
            NSArray *removeFriendsArray = [updateManagedObjectContext executeFetchRequest:fetch error:nil];
            for (id friends in removeFriendsArray)
                [updateManagedObjectContext deleteObject:friends];
            
            // Persist the data store
            [updateManagedObjectContext save:nil];

            if (data.count > 0) {
                
                for (NSDictionary *friend in data) {
                    
                    NSString *emailAddress = [friend valueForKey:@"s_email"];
                    NSString *layerID = [friend valueForKey:@"layer_id"];
                    NSString *layerToken = [friend valueForKey:@"layer_token"];
                    
                    NSLog(@"emailAddress = %@", emailAddress);
                    NSLog(@"layerID = %@", layerID);
                    NSLog(@"layerToken = %@", layerToken);
                    
                    Friends *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friends" inManagedObjectContext:updateManagedObjectContext];
                    friend.emailAddress = emailAddress;
                    friend.layer_id = layerID;
                    friend.layer_token = layerToken;
                }
                
                // Persist the data store
                [updateManagedObjectContext save:nil];
            }
        }
        
        if (hud != nil) {
            [hud setProgress:270];
        }
        
        // Complete
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(YES);
        });
    });
}

+ (NSArray *)all {
    
    MTQAppDelegate *delegate = (MTQAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Friends" inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        return nil;
    }
    
    return result;
}

+ (NSArray *)getFriendsEmailAddresses {
    
    MTQAppDelegate *iDelegate = (MTQAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *updateManagedObjectContext = [[NSManagedObjectContext alloc] init];
    updateManagedObjectContext.persistentStoreCoordinator = iDelegate.persistentStoreCoordinator;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Friends"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"emailAddress" ascending:NO]];
    NSArray *fetchResults = [updateManagedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchResults;
}

+ (Friends *)findFriend:(NSString *)emailAddreess {
    
    NSArray *results = [self fetchWithEntityName:@"Friends" predicate:[NSPredicate predicateWithFormat:@"emailAddress = %@", emailAddreess]];
    return results.count > 0 ? (Friends *)[results objectAtIndex:0] : nil;
}

+ (int)count {
    
    MTQAppDelegate *delegate = (MTQAppDelegate *)[[UIApplication sharedApplication] delegate];
    return (int)[delegate.managedObjectContext countForFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Friends"] error:nil];
}

+ (Friends *)getFriendName:(NSString *)userID {

    NSArray *results = [self fetchWithEntityName:@"Friends" predicate:[NSPredicate predicateWithFormat:@"layer_id = %@", userID]];
    return results.count > 0 ? (Friends *)[results objectAtIndex:0] : nil;
}

@end
