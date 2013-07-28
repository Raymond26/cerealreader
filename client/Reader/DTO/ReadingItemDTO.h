//
// Created by Mike Odom on 7/27/13.
//
//


#import <Foundation/Foundation.h>
#import "BaseDTO.h"
#import "BookDTO.h"


@interface ReadingItemDTO : BaseDTO


@property (readwrite) NSInteger id;
@property (readwrite) NSInteger startDate;

@property (retain) NSString *currentThoughts;

@property (retain) BookDTO *book;

@end