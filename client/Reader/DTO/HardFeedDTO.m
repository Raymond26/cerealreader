//
// Created by Mike Odom on 7/28/13.
//
//


#import "HardFeedDTO.h"
#import "BookDTO.h"


@implementation HardFeedDTO {

}

+ (Class)recommendations_class {
	return [BookDTO class];
}

+ (Class)friendsActivity_class {
	return [BookDTO class];
}

+ (Class)topRated_class {
	return [BookDTO class];
}

@end