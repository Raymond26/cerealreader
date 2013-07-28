//
//  CurrentlyReadingDataSource.m
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "CurrentlyReadingDataSource.h"
#import "ProfileCurrentlyReadingView.h"
#import "ReadingItemDTO.h"
#import "AsyncImageView.h"

@implementation CurrentlyReadingDataSource {
    UINib *viewNib;
}

- (id)initWithReadingItems:(NSArray*)theReadingItems
{
    self = [super init];
    if (self) {
		readingItems = theReadingItems;

        viewNib = [UINib nibWithNibName:@"ProfileCurrentlyReadingView" bundle:[NSBundle mainBundle]];
    }
    return self;
}

/*
@protocol iCarouselDataSource <NSObject>

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel;
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view;

@optional

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel;
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view;

@end*/

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [readingItems count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(ProfileCurrentlyReadingView *)view {
    if ( !view ) {
        view = [ProfileCurrentlyReadingView itemFromNib:viewNib];
    }

	ReadingItemDTO *item = [readingItems objectAtIndex:index];
	BookDTO *book = item.book;
    
    view.titleLabel.text = book.title;
	view.authorLabel.text = book.author;
	view.messageLabel.text = item.currentThoughts;
	//view.messageLabel.text = book.isbn
    
    //set image URL. AsyncImageView class will then dynamically load the image
	NSURL *imageURL;
    
	if ( book.thumbnail )
		imageURL = [NSURL URLWithString:book.thumbnail relativeToURL:nil];
	else
		imageURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"currently_reading@2x" ofType:@"png"]];
    
	//cancel any previously loading images for this view
	[[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view.imageView];
	view.imageView.imageURL = imageURL;    
    
    return view;
}

@end
