//
//  FriendsViewController.m
//  Reader
//
//  Created by Mike Odom on 7/28/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "FriendsViewController.h"
#import "UIViewController+Extras.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *image = [UIImage imageNamed:@"Friend-Activity"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    scrollView.contentSize = imageView.frame.size;
    
    [scrollView addSubview:imageView];

	[self addReaderNavigationItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
