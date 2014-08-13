//
//  GONetworkController.m
//  GoOut
//
//  Created by Liang GUO on 6/30/14.
//  Copyright (c) 2014 bst. All rights reserved.
//
static NSString *interfaceName[] = {
    @"interface_login",
    @"interface_register",
    @"interface_forgot_password",
    @"interface_set_password",
    @"interface_update_location",
    @"interface_fetch_location",
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
#import "GODocument.h"
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
    void (^success)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKeyPath:@"Result"] isEqualToString:@"1"]) {
            GODocument* doc = [GODocument fetchDocument];
            doc.userID= [responseObject valueForKeyPath:@"UserID"];
            doc.userAccount = [responseObject valueForKeyPath:@"UserAccount"];
            doc.userImage = [responseObject valueForKeyPath:@"UserImage"];
            doc.background = [responseObject valueForKeyPath:@"Background"];
            doc.nickName = [responseObject valueForKeyPath:@"NickName"];
            doc.qqAccount = [responseObject valueForKeyPath:@"QQAccount"];
            doc.renAccount = [responseObject valueForKeyPath:@"RenAccount"];
            doc.weiAccount = [responseObject valueForKeyPath:@"WeiAccount"];
            
            [doc saveDocument];
            [self setResultIdentifier:LOGIN_SUCCESS];
        } else {
            [self setResultIdentifier:LOGIN_FAILURE];
        }
    };
    
    void (^failure)(AFHTTPRequestOperation *operation,NSError *error) = ^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        [self setResultIdentifier:LOGIN_TIME_OUT];
    };
    
    //post the data
    [self doPost:LOGIN params:params success:success failure:failure];
}

- (void)doRegister:(NSString *)phoneNum authenticateCode:(NSString *)code
{
    //define the parameters
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum, @"phoneNumber",code,@"MsgCode", nil];
    
    //define the success and failure block
    void (^success)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKeyPath:@"Result"] isEqualToString:@"1"]) {
            
            [self setResultIdentifier:REGISTER_SUCCESS];
        } else {
            [self setResultIdentifier:REGISTER_FAILURE];
        }
    };
    
    void (^failure)(AFHTTPRequestOperation *operation,NSError *error) = ^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        [self setResultIdentifier:REGISTER_TIME_OUT];
    };
    
    //post the data
    [self doPost:REGISTER params:params success:success failure:failure];
}
- (void)doforgotPWD:(NSString *)phoneNum authenticateCode:(NSString *)code
{
    //define the parameters
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum, @"phoneNumber",code,@"MsgCode", nil];
    
    //define the success and failure block
    void (^success)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKeyPath:@"Result"] isEqualToString:@"1"]) {
            
            [self setResultIdentifier:FORGOT_SUCCESS];
        } else {
            [self setResultIdentifier:FORGOT_FAILURE];
        }
    };
    
    void (^failure)(AFHTTPRequestOperation *operation,NSError *error) = ^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        [self setResultIdentifier:FORGOT_TIME_OUT];
    };
    
    //post the data
    [self doPost:FORGOT_PASSWORD params:params success:success failure:failure];
}
/**
 Create an HTTP request and add to operation.
 */
- (void)updateUserLocation:(double)latitude longitude:(double)longitude city:(NSString*)cityName
{
    //define the parameters
    GODocument* doc  = [GODocument fetchDocument];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@(latitude), @"latitude",@(longitude),@"longitude",cityName,@"cityName",doc.userID,@"userID",nil];
    
    //define the success and failure block
    void (^success)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKeyPath:@"Result"] isEqualToString:@"1"]) {
            id convex_hull = [responseObject valueForKeyPath:@"Hull"];
            doc.convex_hull = convex_hull;
            [self setResultIdentifier:UPDATELOC_SUCCESS];
        } else {
            [self setResultIdentifier:UPDATELOC_FAILURE];
        }
    };
    
    void (^failure)(AFHTTPRequestOperation *operation,NSError *error) = ^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        [self setResultIdentifier:UPDATELOC_TIME_OUT];
    };
    
    //post the data
    [self doPost:UPDATELOCATION params:params success:success failure:failure];
}
- (void)fetchUserTerritory
{
    //define the parameters
    GODocument* doc  = [GODocument fetchDocument];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:doc.userID,@"userID",nil];
    
    //define the success and failure block
    void (^success)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKeyPath:@"Result"] isEqualToString:@"1"]) {
            //get user convex hull array
            id convex_hull = [responseObject valueForKeyPath:@"Hull"];
            doc.convex_hull = convex_hull;//[responseObject valueForKeyPath:@"Hull"];
            [self setResultIdentifier:FETCH_CONVEX_HULL_SUCCESS];
        } else {
            [self setResultIdentifier:FETCH_CONVEX_HULL_FAILURE];
        }
    };
    
    void (^failure)(AFHTTPRequestOperation *operation,NSError *error) = ^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        [self setResultIdentifier:FETCH_CONVEX_HULL_TIME_OUT];
    };
    
    //post the data
    [self doPost:FETCH_CONVEX_HULL params:params success:success failure:failure];
}
- (void)doPost:(INTERFACE_TYPE)interface params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    //NSString *url = [URL_BASE stringByAppendingString:@"welcome.php"];
    NSString *url = [URL_BASE stringByAppendingString:interfaceName[interface]];
    AFHTTPRequestOperationManager *httpManager = [[AFHTTPRequestOperationManager alloc] init];
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",nil];
    [httpManager POST:url parameters:params success:success failure:failure];
    //url = [self printHTTPUrlWithBaseUrl:url parameters:params];

}
- (NSString*)printHTTPUrlWithBaseUrl:(NSString *)url
                     parameters:(NSDictionary *)parameters {
    
    NSString *httpUrl = nil;
    NSString *dicKey = nil;
    if (parameters == nil) {
        return nil;
    }
    for (int i = 0; i < [[parameters allKeys] count]; i++) {
        httpUrl = i == 0 ? @"?" : [httpUrl stringByAppendingString:@"&"];
        
        dicKey = [parameters allKeys][i];
        httpUrl = [httpUrl stringByAppendingFormat:@"%@=%@", dicKey, parameters[dicKey]];
    }
    httpUrl = [url stringByAppendingString:httpUrl];
    
    NSLog(@"\n-----------------[HTTP Url]-----------------\n%@\
         \n--------------------------------------------", httpUrl);
    return httpUrl;
}
@end
