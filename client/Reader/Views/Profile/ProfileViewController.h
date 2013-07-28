//
//  ViewController.h
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "SwipeView.h"
#import "CurrentlyReadingDataSource.h"
#import "CompletedReadingDataSource.h"

@interface ProfileViewController : UIViewController {
    IBOutlet UIImageView *profileImageView;
    IBOutlet UILabel *profileImageViewSubLabel;
    
    IBOutlet UIView *backgroundCarousel;
    
    IBOutlet SwipeView *completedView;
    IBOutlet iCarousel *currentlyReadingView;
    
    CurrentlyReadingDataSource *currentlyReadingDataSource;
    CompletedReadingDataSource *completedReadingDataSource;
}

@end
