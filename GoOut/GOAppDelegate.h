//
//  GOAppDelegate.h
//  GoOut
//
//  Created by Liang GUO on 6/20/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
