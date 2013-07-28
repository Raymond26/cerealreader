//
//  BookDetailViewController.m
//  Reader
//
//  Created by Mike Odom on 7/28/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookDTO.h"
#import "AppDelegate.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIScrollView *scrollView = (UIScrollView*)self.view;

	scrollView.bounces = NO;
	scrollView.delegate = self;
    
    CGSize size = contentView.frame.size;
    
    size.height += 200;
    
    CGRect contentFrame = contentView.frame;
    contentFrame.origin.y += 200;
    contentView.frame = contentFrame;
    
    scrollView.contentSize = size;
    
    [scrollView addSubview:contentView];
    
    titleLabel.text = _book.title;
	authorLabel.text = _book.author;
	ratingControl.rating = [_book.averageRating floatValue];
	ratingControl.ratingsCount = [_book.ratingsCount intValue];
	descriptionTextView.text = _book.description;

    NSString *imageURL;
    if ( _book.thumbnail )
		imageURL = [NSURL URLWithString:_book.thumbnail relativeToURL:nil];
	else
		imageURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Book1@2x" ofType:@"png"]];
    
	//cancel any previously loading images for this view
	[[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:coverImageView];
	coverImageView.imageURL = imageURL;

}

- (void)addToView:(UIView*)aView {
	self.view.alpha = 0;

	UIScrollView *scrollView = (UIScrollView*)self.view;

	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

	self.view.alpha = 1;
	[scrollView scrollRectToVisible:CGRectMake(0, 400, 1, 320) animated:NO];

	[UIView commitAnimations];

	[aView addSubview:self.view];
}

- (void)removeFromView {
	UIScrollView *scrollView = (UIScrollView*)self.view;

	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

	self.view.alpha = 0;
	[scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 320) animated:NO];

	[UIView setAnimationDidStopSelector:@selector(removeFromViewAnimationDidStop)];

	[UIView commitAnimations];


}

- (void)removeFromViewAnimationDidStop {
	[self.view removeFromSuperview];
}

- (void)setBook:(BookDTO*)book {
	_book = book;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

	float y = scrollView.contentOffset.y;

	float alpha = 0;
	if ( y > 200 )
		alpha = 1;
	else
		alpha = y / 200;

	NSLog(@"%f", y);

	scrollView.backgroundColor =  [UIColor colorWithWhite:0 alpha:alpha * 0.6];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	float y = scrollView.contentOffset.y;

	if ( y < 100 )
		[self removeFromView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	float y = scrollView.contentOffset.y;

	if ( y < 100 )
		[self removeFromView];
}


@end
