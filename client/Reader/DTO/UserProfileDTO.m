//
//  UserProfileDTO.m
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "UserProfileDTO.h"

@implementation UserProfileDTO

/**
 * Tell Jastor what class this array holds
 */
+ (Class)currentReading_class {
    return [CurrentReadingDTO class];
}

/**
 * Tell Jastor what class this array holds
 */
+ (Class)finishedReading_class {
    return [CurrentReadingDTO class];
}

@end
