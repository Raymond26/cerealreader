//
// Created by Mike Odom on 7/28/13.
//
//


#import <Foundation/Foundation.h>
#import "BaseDTO.h"


@interface HardFeedDTO : BaseDTO

@property (retain) NSArray *recommendations;
@property (retain) NSArray *friendsActivity;
@property (retain) NSArray *topRated;

@end