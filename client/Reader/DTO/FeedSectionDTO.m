//
// Created by Mike Odom on 7/28/13.
//
//


#import "FeedSectionDTO.h"
#import "BookDTO.h"
#import "FeedSectionDataSource.h"


@implementation FeedSectionDTO {

}

- (Class)feedItems_class {
	return [BookDTO class];
}

- (FeedSectionDataSource *)dataSource {
	if ( !_dataSource ) {
		_dataSource = [[FeedSectionDataSource alloc] initWithFeedSection:self];
	}

	return _dataSource;
}


@end