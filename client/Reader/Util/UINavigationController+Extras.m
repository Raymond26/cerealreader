//
// Created by Mike Odom on 7/28/13.
//
//


#import "UINavigationController+Extras.h"


@implementation UIViewController (Extras)

//Such a hack!
- (void)addReaderNavigationItems {
	UIBarButtonItem *lastItem = self.navigationItem.leftBarButtonItem;

	UIImage *menuImage = [UIImage imageNamed:@"menu_button"];
	UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
	menuButton.bounds = CGRectMake( 0, 0, menuImage.size.width, menuImage.size.height );
	[menuButton setImage:menuImage forState:UIControlStateNormal];
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

	[menuButton addTarget:lastItem.target action:lastItem.action forControlEvents:UIControlEventTouchUpInside];

	self.navigationItem.leftBarButtonItem = leftButton;


	lastItem = self.navigationItem.rightBarButtonItem;

	UIImage *searchImage = [UIImage imageNamed:@"search_button"];
	UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
	searchButton.bounds = CGRectMake( 0, 0, searchImage.size.width, searchImage.size.height );
	[searchButton setImage:searchImage forState:UIControlStateNormal];
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:searchButton];

	[searchButton addTarget:lastItem.target action:lastItem.action forControlEvents:UIControlEventTouchUpInside];

	self.navigationItem.rightBarButtonItem = rightButton;
}
@end