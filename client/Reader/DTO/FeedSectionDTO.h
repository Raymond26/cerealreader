//
// Created by Mike Odom on 7/28/13.
//
//


#import <Foundation/Foundation.h>
#import "BaseDTO.h"

@class FeedSectionDataSource;


@interface FeedSectionDTO : BaseDTO {
    FeedSectionDataSource *_dataSource;
}

@property (retain) NSString *title;
@property (retain) NSArray *items;

@property (readonly) FeedSectionDataSource *dataSource;

@end