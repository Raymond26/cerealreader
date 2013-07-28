//
//  FeedItemControl.m
//  Reader
//
//  Created by Mike Odom on 7/28/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "FeedItemControl.h"
#import "BookDTO.h"
#import "AsyncImageView.h"

@implementation FeedItemControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)itemFromNib:(UINib*)nib {
    NSArray *objects = [nib instantiateWithOwner:nil options:nil];
    
    for (id object in objects) {
        if( [object isKindOfClass:[self class]] ) {
            return object;
        }
    }
    
    [NSException raise:NSObjectNotAvailableException format:@"Could not create item from nib"];
    
    return NULL;
}

- (void)setBook:(BookDTO*)book {
	if ( !book ) {
		self.alpha = 0;

		return;
	}

	self.alpha = 1;

	self.titleLabel.text = book.title;
	self.authorLabel.text = book.author;

	self.ratingControl.rating = [book.averageRating floatValue];
	self.ratingControl.ratingsCount = [book.ratingsCount intValue];


	//set image URL. AsyncImageView class will then dynamically load the image
	NSURL *imageURL;

	if ( book.thumbnail )
		imageURL = [NSURL URLWithString:book.thumbnail relativeToURL:nil];
	else
		imageURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Book1@2x" ofType:@"png"]];

	//cancel any previously loading images for this view
	[[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.imageView];
	self.imageView.imageURL = imageURL;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
