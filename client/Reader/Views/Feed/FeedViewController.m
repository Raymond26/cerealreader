//
// Created by Mike Odom on 7/28/13.
//
//


#import "FeedViewController.h"
#import "BookDTO.h"
#import "AsyncImageView.h"
#import "FeedItemControl.h"
#import "FeedDTO.h"
#import "FeedSectionDataSource.h"
#import "UINavigationController+Extras.h"
#import "FeedSectionFocusViewController.h"
#import "HardFeedDTO.h"
#import "CallbackHandler.h"
#import "AppDelegate.h"


@implementation FeedViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

	/*
	_feedDTO = [[FeedDTO alloc] init];
	NSMutableArray *newFeedSections = [NSMutableArray new];
	_feedDTO.sections = newFeedSections;

	FeedSectionDTO *feedSection = [FeedSectionDTO new];
	[newFeedSections addObject:feedSection];

	NSMutableArray *newFeedItems = [NSMutableArray new];
	feedSection.title = @"Recommendations";
	feedSection.items = newFeedItems;
    
    BookDTO *book = [BookDTO new];
    
    book.title = @"Test book";
    book.author = @"Batman";
    book.thumbnail = @"http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api";
    
    book = [BookDTO new];
    [newFeedItems addObject:book];
    
    book.title = @"New book";
    book.author = @"Robin";
    book.thumbnail = @"http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api";
    
    [newFeedItems addObject:book];
    
    
    feedSection = [FeedSectionDTO new];
	[newFeedSections addObject:feedSection];
    
	newFeedItems = [NSMutableArray new];
	feedSection.title = @"Friend stuff";
	feedSection.items = newFeedItems;
    
    book = [BookDTO new];
    
    book.title = @"Test book";
    book.author = @"Batman";
    book.thumbnail = @"http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api";
    
    [newFeedItems addObject:book];
    
    book = [BookDTO new];    
    book.title = @"New book";
    book.author = @"Robin";
    book.thumbnail = @"http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api";
    
    [newFeedItems addObject:book];

	book = [BookDTO new];
	book.title = @"New book";
	book.author = @"Moooo";
	book.thumbnail = @"http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api";

	[newFeedItems addObject:book];*/

	[[CallbackHandler instance] doRequestWithPath:@"/users/1/feed/1" params:nil expectedDTO:[HardFeedDTO class] delegate:self successSelector:@selector(dataLoaded:) failureSelector:nil];

	[self addReaderNavigationItems];

	((AppDelegate*)[[UIApplication sharedApplication] delegate]).currentViewController = self;
}

- (void)dataLoaded:(HardFeedDTO*)hardFeedDTO {
	_feedDTO = [[FeedDTO alloc] init];
	NSMutableArray *newFeedSections = [NSMutableArray new];
	_feedDTO.sections = newFeedSections;

	FeedSectionDTO *recommendations = [FeedSectionDTO new];
	recommendations.title = @"Recommendations";
	recommendations.items = hardFeedDTO.recommendations;

	[newFeedSections addObject:recommendations];

	FeedSectionDTO *friendsActivity = [FeedSectionDTO new];
	friendsActivity.title = @"Friend Activity";
	friendsActivity.items = hardFeedDTO.friendsActivity;

	[newFeedSections addObject:friendsActivity];


	FeedSectionDTO *topRated = [FeedSectionDTO new];
	topRated.title = @"Top Rated";
	topRated.items = hardFeedDTO.topRated;

	[newFeedSections addObject:topRated];

	[_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[_feedDTO sections] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)index {
	FeedSectionDTO *section = [_feedDTO.sections objectAtIndex:(NSUInteger)index];

	return section.title;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *view = [tableView dequeueReusableCellWithIdentifier:@"feedSection"];

	if ( !view ) {
		view = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];

		SwipeView *swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
		[view addSubview:swipeView];
	}

	int index = [indexPath indexAtPosition:0];
	FeedSectionDTO *feedSection = [[_feedDTO sections] objectAtIndex:(NSUInteger)index];
	FeedSectionDataSource *dataSource = feedSection.dataSource;

	SwipeView *swipeView = [[view subviews] objectAtIndex:1];
	swipeView.dataSource = dataSource;
	swipeView.delegate = dataSource;

	return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)index
{
	FeedSectionDTO *section = [_feedDTO.sections objectAtIndex:(NSUInteger)index];

	UIButton *header = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 26.0)];
	header.tag = index;
	header.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];

	CGRect textFrame = CGRectMake(0, 0, tableView.frame.size.width, 26);
	UILabel *textLabel = [[UILabel alloc] initWithFrame:textFrame];
	textLabel.text = section.title;
	textLabel.textColor = [UIColor blackColor];
	textLabel.backgroundColor = [UIColor clearColor];
	textLabel.textAlignment = NSTextAlignmentCenter;


	UIFont *font = [UIFont fontWithName:@"Gotham-Medium" size:16];
	textLabel.font = font;

	[header addSubview:textLabel];

	[header addTarget:self action:@selector(sectionSelected:) forControlEvents:UIControlEventTouchUpInside];

	return header;
}

- (void)sectionSelected:(UIView*)header {
	NSUInteger index = (NSUInteger)header.tag;

	FeedSectionDTO *section = [_feedDTO.sections objectAtIndex:(NSUInteger)index];

	UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
	FeedSectionFocusViewController * vc = [sb instantiateViewControllerWithIdentifier:@"FeedSectionFocusViewController"];

	vc.section = section;

	[vc.tableView reloadData];

	[self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 26.0;
}



@end