//
//  ProfileCurrentlyReadingView.h
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ProfileCurrentlyReadingView : UIView

+ (id)itemFromNib:(UINib*)nib;

@property (retain) IBOutlet UILabel *titleLabel;
@property (retain) IBOutlet UILabel *authorLabel;
@property (retain) IBOutlet UILabel *messageLabel;
@property (retain) IBOutlet AsyncImageView *imageView;


@end
