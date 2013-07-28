//
//  FeedSectionFocusViewController.h
//  Reader
//
//  Created by Mike Odom on 7/28/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedSectionDTO.h"

@interface FeedSectionFocusViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {

}

@property (retain) FeedSectionDTO *section;

@end
