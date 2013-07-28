//
//  FeedItemControl.h
//  Reader
//
//  Created by Mike Odom on 7/28/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingControl.h"

@interface FeedItemControl : UIView

+ (id)itemFromNib:(UINib*)nib;

@property (retain) IBOutlet UIImageView *imageView;
@property (retain) IBOutlet UILabel *titleLabel;
@property (retain) IBOutlet UILabel *authorLabel;
@property (retain) IBOutlet RatingControl *ratingControl;


@end
