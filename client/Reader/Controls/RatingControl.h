//
// Created by Mike Odom on 7/28/13.
//
//


#import <Foundation/Foundation.h>


@interface RatingControl : UIView {
	float _rating;
}

@property (readwrite) float rating;
@property (readwrite) float ratingsCount;

@end