//
//  CurrentlyReadingDataSource.h
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCarousel.h"

@interface CurrentlyReadingDataSource : NSObject <iCarouselDataSource> {
	NSArray *readingItems;
}

- (id)initWithReadingItems:(NSArray*)theReadingItems;

@end
