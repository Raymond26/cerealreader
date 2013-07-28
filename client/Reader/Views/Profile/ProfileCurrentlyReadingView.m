//
//  ProfileCurrentlyReadingView.m
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "ProfileCurrentlyReadingView.h"

@implementation ProfileCurrentlyReadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)itemFromNib:(UINib*)nib {
    NSArray *objects = [nib instantiateWithOwner:nil options:nil];

    for (id object in objects) {
        if( [object isKindOfClass:[self class]] ) {
            return object;
        }
    }
    
    [NSException raise:NSObjectNotAvailableException format:@"Could not create item from nib"];
    
    return NULL;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
