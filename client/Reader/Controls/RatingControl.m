//
// Created by Mike Odom on 7/28/13.
//
//


#import "RatingControl.h"


@implementation RatingControl {
	UIImage *_onStar;
	UIImage *_offStar;

	NSMutableArray *_ratingStars;
}


- (void)awakeFromNib {
	_onStar = [UIImage imageNamed:@"star"];
	_offStar = [UIImage imageNamed:@"grey_star"];

	_ratingStars = [NSMutableArray new];
}

- (float)rating {
	return _rating;
}

- (void)setRating:(float)rating {
	_rating = rating;

	CGRect starFrame = CGRectZero;
	starFrame.size = _onStar.size;

	for ( NSUInteger t = 0; t < 5; t++) {
		UIImageView *star;

		if ( [_ratingStars count] <= t ) {
			star = [[UIImageView alloc] initWithFrame:starFrame];
			[self addSubview:star];
		} else {
			star = [_ratingStars objectAtIndex:t];
		}

		if ( t < rating ) {
			star.image = _onStar;
		} else {
			star.image = _offStar;
		}

		starFrame.origin.x += starFrame.size.width + 2;
	}
}


@end