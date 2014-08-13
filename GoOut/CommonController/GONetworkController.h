//
//  GONetworkController.h
//  GoOut
//
//  Created by Liang GUO on 6/30/14.
//  Copyright (c) 2014 bst. All rights reserved.
//
#define MAX_CONCURRENCY 32
// Test
//#define URL_BASE @"http://ge-api-test.application-test.com/?a="
#define URL_BASE @"http://192.168.16.3/?a="
typedef NS_ENUM(NSInteger, INTERFACE_TYPE) {
    LOGIN = 0,
    REGISTER,
    FORGOT_PASSWORD,
    SET_PASSWORD,
    UPDATELOCATION,
    FETCH_CONVEX_HULL,
    GET_DATASHEETS,
    GET_LITERATURES,
    DOWNLOAD_FILE,
    DOWNLOAD_FINISH,
    CHECK_VERSION,
    GET_INFO,
};
typedef NS_ENUM(NSInteger, IDENTIFIER) {
    LOGIN_FAILURE = 0,
    LOGIN_SUCCESS,
    LOGIN_TIME_OUT,
    REGISTER_FAILURE,
    REGISTER_SUCCESS,
    REGISTER_TIME_OUT,
    FORGOT_FAILURE,
    FORGOT_SUCCESS,
    FORGOT_TIME_OUT,
    SETPWD_FAILURE,
    SETPWD_SUCCESS,
    SETPWD_TIME_OUT,
    UPDATELOC_FAILURE,
    UPDATELOC_SUCCESS,
    UPDATELOC_TIME_OUT,
    FETCH_CONVEX_HULL_FAILURE,
    FETCH_CONVEX_HULL_SUCCESS,
    FETCH_CONVEX_HULL_TIME_OUT,
    CHANGE_FAILURE,
    CHANGE_SUCCESS,
    DATASHEETS_FAILURE,
    DATASHEETS_SUCCESS,
    LITERATURES_FAILURE,
    LITERATURES_SUCCESS,
    DOWNLOADFILE_FAILURE,
    DOWNLOADFILE_SUCCESS,
    DOWNLOADFINISH_FAILURE,
    DOWNLOADFINISH_SUCCESS,
    CHECKVERSION_FAILURE,
    CHECKVERSION_SUCCESS,
    CHECKVERSION_TIMEOUT,
    GET_INFO_FAILURE,
    GET_INFO_SUCCESS,
    NETWORK_DISABLE,
};

#import <Foundation/Foundation.h>

@interface GONetworkController : NSObject

@property (nonatomic, retain) NSOperationQueue *serialRequestQueue;
@property (nonatomic, retain) NSOperationQueue *concurrentDownloadQueue;

@property (nonatomic, retain) NSMutableDictionary *downloadProgressDict;
@property (nonatomic, retain) NSMutableDictionary *downloadIndexDict;

+ (GONetworkController *)sharedController;
- (void)doLogin:(NSString *)phoneNum password:(NSString *)password;
- (void)doRegister:(NSString *)phoneNum authenticateCode:(NSString *)code;
- (void)doforgotPWD:(NSString *)phoneNum authenticateCode:(NSString *)code;

- (void)updateUserLocation:(double)latitude longitude:(double)longitude city:(NSString*)cityName;
- (void)fetchUserTerritory;
@end
