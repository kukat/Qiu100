//
//  QiuShiBaiKeAppDelegate.h
//  QiuShiBaiKe
//
//  Created by Cheng Yao on 5/3/11.
//  Copyright 2011 Alex Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSplitCascadeViewController;

@interface QiuShiBaiKeAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CLSplitCascadeViewController *viewController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
