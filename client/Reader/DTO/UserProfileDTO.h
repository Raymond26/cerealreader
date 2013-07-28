//
//  UserProfileDTO.h
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "BaseDTO.h"
#import "CurrentReadingDTO.h"
#import "UserReadDTO.h"
#import "BasicUserDTO.h"

@interface UserProfileDTO : BaseDTO

@property (retain) NSArray *currentReading;
@property (retain) NSArray *finishedReading;

@property (retain) BasicUserDTO *user;

@end
