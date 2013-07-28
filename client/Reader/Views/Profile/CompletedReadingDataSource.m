//
//  CompletedReadingDataSource.m
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "CompletedReadingDataSource.h"
#import "AsyncImageView.h"
#import "BookDTO.h"
#import "ReadingItemDTO.h"

@implementation CompletedReadingDataSource


- (id)initWithReadingItems:(NSArray*)theReadingItems {
	self = [super init];
	if (self) {
		readingItems = theReadingItems;
	}

	return self;
}


- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return [readingItems count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if ( !view ) {
//        view = [ProfileCurrentlyReadingView itemFromNib:viewNib];
    }
    
//    view.titleLabel.text = @"moo";

	//http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api

	if (view == nil)
	{
		view = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 58.0f, 100.0f)] autorelease];
		view.contentMode = UIViewContentModeScaleAspectFit;
	}

	ReadingItemDTO *item = [readingItems objectAtIndex:index];
	BookDTO *book = item.book;

	//set image URL. AsyncImageView class will then dynamically load the image
	NSURL *imageURL;

	if ( book.thumbnail )
		imageURL = [NSURL URLWithString:book.thumbnail relativeToURL:nil];
	else
		imageURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Book1@2x" ofType:@"png"]];

	//cancel any previously loading images for this view
	[[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view];
	((AsyncImageView *)view).imageURL = imageURL;

    return view;
}


- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return CGSizeMake(64, 90);
}

@end
