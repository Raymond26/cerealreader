//
//  BookDetailViewController.h
//  Reader
//
//  Created by Mike Odom on 7/28/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingControl.h"
#import "AsyncImageView.h"

@class BookDTO;

@interface BookDetailViewController : UIViewController <UIScrollViewDelegate> {
    BookDTO *_book;
    
    IBOutlet AsyncImageView *coverImageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *authorLabel;
    IBOutlet UITextView *descriptionTextView;
    
    IBOutlet RatingControl *ratingControl;
    
    IBOutlet UIView *contentView;
}

- (void)setBook:(BookDTO*)book;

- (void)addToView:(UIView*)aView;

@end
