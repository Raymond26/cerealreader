//
// Created by Mike Odom on 7/28/13.
//
//


#import <Foundation/Foundation.h>
#import "SwipeView.h"

@interface FeedViewController : UIViewController <SwipeViewDelegate, SwipeViewDataSource> {
    IBOutlet SwipeView *mainSwipeView;
}

@end