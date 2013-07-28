//
// Created by Mike Odom on 7/27/13.
//
//


#import <Foundation/Foundation.h>
#import "BaseDTO.h"


@interface BookDTO : BaseDTO

@property (retain) NSNumber *id;
@property (readwrite) NSString *isbn;
@property (retain) NSString *title;
@property (retain) NSString *author;
@property (retain) NSString *thumbnail;
@property (retain) NSNumber *averageRating;
@property (retain) NSNumber *ratingsCount;

@end