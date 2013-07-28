//
//  FeedSectionFocusViewController.m
//  Reader
//
//  Created by Mike Odom on 7/28/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "FeedSectionFocusViewController.h"
#import "FeedItemControl.h"
#import "BookDTO.h"
#import "UINavigationController+Extras.h"
#import "AppDelegate.h"

@interface FeedSectionFocusViewController ()

@end

@implementation FeedSectionFocusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.allowsSelection = NO;

	[self addReaderNavigationItems];

	((AppDelegate*)[[UIApplication sharedApplication] delegate]).currentViewController = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (NSInteger)ceil([_section.items count] / 2.0f);
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *view = [tableView dequeueReusableCellWithIdentifier:@"feedSection"];

	if ( !view ) {
		static UINib *viewNib = nil;
		if ( !viewNib ) {
			viewNib = [UINib nibWithNibName:@"FeedItemControl" bundle:[NSBundle mainBundle]];
		}

		view = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 164)];
		view.autoresizesSubviews = NO;

		FeedItemControl *leftItem = [FeedItemControl itemFromNib:viewNib];

		CGRect itemFrame = leftItem.frame;
		itemFrame.origin.x = 8;
		itemFrame.origin.y = 4;

		leftItem.frame = itemFrame;

		leftItem.tag = 100;
		[view addSubview:leftItem];

		itemFrame.origin.x += itemFrame.size.width + 8;

		FeedItemControl *rightItem = [FeedItemControl itemFromNib:viewNib];
		rightItem.frame = itemFrame;
		rightItem.tag = 101;
		[view addSubview:rightItem];

	}

	int index = [indexPath indexAtPosition:1];

	BookDTO *leftBook = [_section.items objectAtIndex:(NSUInteger)index*2];
	FeedItemControl *leftItem = (FeedItemControl*)[view viewWithTag:100];

	[leftItem setBook:leftBook];

	BookDTO *rightBook = ([_section.items count] > index*2+1) ? [_section.items objectAtIndex:(NSUInteger)index*2+1] : nil;
	FeedItemControl *rightItem = (FeedItemControl*)[view viewWithTag:101];

	[rightItem setBook:rightBook];

	return view;
}

@end
