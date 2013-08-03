//
//  TestAppDelegate.h
//  test7
//
//  Created by Администратор on 6/16/13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class TestViewController;

@interface TestAppDelegate : UIResponder <UIApplicationDelegate>{
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TestViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;


@end
