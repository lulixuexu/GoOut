//
//  GONetworkController.h
//  GoOut
//
//  Created by Liang GUO on 6/30/14.
//  Copyright (c) 2014 bst. All rights reserved.
//
#define MAX_CONCURRENCY 32
// Test
#define URL_BASE @"http://ge-api-test.application-test.com/?a="

typedef NS_ENUM(NSInteger, INTERFACE_TYPE) {
    LOGIN = 0,
    CHANGE_PASSWORD,
    FORGET_PASSWORD,
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
    CHANGE_FAILURE,
    CHANGE_SUCCESS,
    FORGET_FAILURE,
    FORGET_SUCCESS,
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
@end
