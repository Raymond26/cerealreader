//
// Created by Mike Odom on 7/28/13.
//
//


#import "UIViewController+Extras.h"
#import "FriendsViewController.h"


@implementation UIViewController (Extras)

//Such a hack!
- (void)addReaderNavigationItems {
	UIBarButtonItem *lastItem = self.navigationItem.leftBarButtonItem;

	UIImage *menuImage = [UIImage imageNamed:@"menu_button"];
	UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
	menuButton.bounds = CGRectMake( 0, 0, menuImage.size.width, menuImage.size.height );
	[menuButton setImage:menuImage forState:UIControlStateNormal];
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

//	[menuButton addTarget:lastItem.target action:lastItem.action forControlEvents:UIControlEventTouchUpInside];
    
	[menuButton addTarget:self action:@selector(menuButtonPressed) forControlEvents:UIControlEventTouchUpInside];

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

- (void)menuButtonPressed {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What would you like to do?"
	                                                             delegate:self
	                                                    cancelButtonTitle:nil
	                                               destructiveButtonTitle:nil
	                                                    otherButtonTitles:nil];

	[actionSheet addButtonWithTitle:@"Home"];
	[actionSheet addButtonWithTitle:@"Friend Activity"];

	actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
	[actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if ( buttonIndex == 0 ) {
		UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
		UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"HomeViewController"];

		[[self navigationController] pushViewController:vc animated:YES];
	}

	if ( buttonIndex == 1 ) {
		UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
		UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FriendsViewController"];

		//FriendsViewController *vc = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:nil];

		[[self navigationController] setViewControllers:[NSArray arrayWithObject:vc] animated:YES];
	}
}


@end
