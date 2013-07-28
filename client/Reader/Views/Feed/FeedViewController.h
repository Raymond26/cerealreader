//
// Created by Mike Odom on 7/28/13.
//
//


#import <Foundation/Foundation.h>
#import "SwipeView.h"

@class FeedDTO;

@interface FeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet UITableView *_tableView;

	FeedDTO *_feedDTO;
}

@end