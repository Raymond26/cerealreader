//
// Created by Mike Odom on 7/28/13.
//
//


#import "FeedViewController.h"
#import "BookDTO.h"
#import "AsyncImageView.h"
#import "FeedItemControl.h"


@implementation FeedViewController {
    NSArray *_feedItems;
    
    UINib *viewNib;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    mainSwipeView.vertical = YES;
    
    NSMutableArray *newFeedItems = [NSMutableArray new];
    
    BookDTO *book = [BookDTO new];
    
    book.title = @"Test book";
    book.author = @"Batman";
    book.thumbnail = @"http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api";
    
    [newFeedItems addObject:book];
    
    book.title = @"New book";
    book.author = @"Robin";
    book.thumbnail = @"http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api";
    
    [newFeedItems addObject:book];
    
    
    _feedItems = newFeedItems;
    
    viewNib = [UINib nibWithNibName:@"FeedItemControl" bundle:[NSBundle mainBundle]];
    
    [mainSwipeView reloadData];
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return [_feedItems count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(FeedItemControl *)view {
    if ( !view ) {
        view = [FeedItemControl itemFromNib:viewNib];
    }
    
    //    view.titleLabel.text = @"moo";
    
	//http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api
    
    BookDTO *book = [_feedItems objectAtIndex:index];
    
	//set image URL. AsyncImageView class will then dynamically load the image
	NSURL *imageURL;
    
	if ( book.thumbnail )
		imageURL = [NSURL URLWithString:book.thumbnail relativeToURL:nil];
	else
		imageURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Book1@2x" ofType:@"png"]];
    
	//cancel any previously loading images for this view
	[[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view.imageView];
    view.imageView.imageURL = imageURL;
    
    view.titleLabel.text = book.title;
    view.authorLabel.text = book.author;
    view.ratingControl.rating = 4;
    
    return view;
}


- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return CGSizeMake(158, 190);
}

@end