//
//  CompletedReadingDataSource.h
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwipeView.h"

@interface CompletedReadingDataSource : NSObject <SwipeViewDataSource, SwipeViewDelegate> {
	NSArray *readingItems;
}

- (id)initWithReadingItems:(NSArray*)theReadingItems;

@end
