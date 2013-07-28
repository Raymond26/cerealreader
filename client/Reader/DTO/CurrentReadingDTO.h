//
// Created by Mike Odom on 7/27/13.
//
//


#import <Foundation/Foundation.h>
#import "BaseDTO.h"
#import "BookDTO.h"


@interface CurrentReadingDTO : BaseDTO

@property (retain) NSNumber *startDate;
@property (retain) NSString *currentThoughts;

@property (retain) BookDTO *book;
@end