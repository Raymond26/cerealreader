//
// Created by Mike Odom on 7/28/13.
//
//


#import "FeedSectionDataSource.h"
#import "FeedSectionDTO.h"
#import "FeedItemControl.h"
#import "BookDTO.h"
#import "AsyncImageView.h"
#import "FeedDTO.h"


@implementation FeedSectionDataSource {
	FeedSectionDTO *_feedSection;
}

- (id)initWithFeedSection:(FeedSectionDTO *)feedSection {
	self = [super init];
	if (self) {
		_feedSection = feedSection;
	}

	return self;
}


- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return [_feedSection.items count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(FeedItemControl *)view {
    if ( !view ) {

		static UINib *viewNib = nil;

		if ( !viewNib ) {
			viewNib = [UINib nibWithNibName:@"FeedItemSmallControl" bundle:[NSBundle mainBundle]];
		}

        view = [FeedItemControl itemFromNib:viewNib];
    }

    BookDTO *book = [_feedSection.items objectAtIndex:(NSUInteger)index];

	[view setBook:book];

    return view;
}


- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return CGSizeMake(90, 125);
}


- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
	FeedItemControl *item = (FeedItemControl*)[swipeView itemViewAtIndex:index];

	[item touchesEnded:nil withEvent:nil];

}


@end