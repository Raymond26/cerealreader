//
// Created by Mike Odom on 7/28/13.
//
//


#import <Foundation/Foundation.h>
#import "SwipeView.h"

@class FeedSectionDTO;
@class FeedDTO;


@interface FeedSectionDataSource : NSObject <SwipeViewDelegate, SwipeViewDataSource>

- (id)initWithFeedSection:(FeedSectionDTO *)feedSection;

@end