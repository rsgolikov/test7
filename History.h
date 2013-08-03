//
//  History.h
//  test7
//
//  Created by Баз Светик on 08.07.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface History : NSManagedObject

@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * shulteValue;
@property (nonatomic, retain) NSString * shulteSize;

@end
