//
//  GONetworkController.m
//  GoOut
//
//  Created by Liang GUO on 6/30/14.
//  Copyright (c) 2014 bst. All rights reserved.
//
static NSString *interfaceName[] = {
    @"interface_login",
    @"interface_change_password",
    @"interface_forget_password",
    @"interface_get_datasheets",
    @"interface_get_literatures",
    @"interface_download_file",
    @"interface_download_finish",
    @"interface_check_version",
    @"interface_get_info",
};

#import "GONetworkController.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "GOCommon.h"
@interface GONetworkController()

@property (nonatomic, retain) NSString *accessToken;
    
@property (nonatomic, assign) NSInteger resultIdentifier;

@end
@implementation GONetworkController

+ (GONetworkController*)sharedController
{
    static GONetworkController* controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
}

- (id)init {
    if (self = [super init]) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        self.serialRequestQueue = [[NSOperationQueue alloc] init];
        self.concurrentDownloadQueue = [[NSOperationQueue alloc] init];
        
        self.downloadProgressDict = [NSMutableDictionary dictionaryWithCapacity:1];
        self.downloadIndexDict = [NSMutableDictionary dictionaryWithCapacity:1];
        
        [_serialRequestQueue setMaxConcurrentOperationCount:1];
        [_concurrentDownloadQueue setMaxConcurrentOperationCount:MAX_CONCURRENCY];
    }
    return self;
}

- (void)doLogin:(NSString *)phoneNum password:(NSString *)password
{
    //define the parameters
    NSString *pwdMD5Str = [GOCommon md5WithString:password];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum, @"phoneNumber", pwdMD5Str, @"password", nil];
    
    //define the success and failure block
    void (^success)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON valueForKeyPath:@"result"] isEqualToString:@"1"] && [JSON valueForKeyPath:@"userid"] != nil) {
//            self.accessToken = [JSON valueForKeyPath:@"authToken"];
//            
//            // Save user info to document when login successful.
//            GEDocument *document = [GEDocument unarchive];
//            document.userID = [NSNumber numberWithInteger:[[JSON valueForKeyPath:@"userid"] integerValue]];
//            document.userEmail = username;
//            document.userPassword = pwdMD5Str;
//            [document saveDocument];
//            
//            NSString *appVersionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//            [self doGetInfo:[GECommon getUUID] version:appVersionStr];
            
            [self setResultIdentifier:LOGIN_SUCCESS];
        } else {
            [self setResultIdentifier:LOGIN_FAILURE];
        }
    };
    
    void (^failure)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [self setResultIdentifier:LOGIN_TIME_OUT];
    };
    
    //post the data
    [self doPost:LOGIN params:params success:success failure:failure];
}
/**
 Create an HTTP request and add to operation.
 */
- (void)doPost:(INTERFACE_TYPE)interface params:(NSDictionary *)params success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
    NSURL *url = [NSURL URLWithString:[URL_BASE stringByAppendingString:interfaceName[interface]]];
    AFHTTPRequestOperationManager
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:success failure:failure];
    operation.tag = interface;
    [_serialRequestQueue addOperation:operation];
}
@end
