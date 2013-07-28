//
//  ViewController.m
//  Reader
//
//  Created by Mike Odom on 7/27/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "ProfileViewController.h"
#import "CurrentlyReadingDataSource.h"
#import "CallbackHandler.h"
#import "UserProfileDTO.h"
#import "UINavigationController+Extras.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController {
    CALayer *cloudLayer;
    CABasicAnimation *cloudLayerAnimation;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    
    currentlyReadingView.scrollSpeed = 0.3;
    currentlyReadingView.bounceDistance = 0.3;
	currentlyReadingView.stopAtItemBoundary = YES;

    completedView.truncateFinalPage = YES;
    
    [[CallbackHandler instance] doRequestWithPath:@"/users/1" params:nil expectedDTO:[UserProfileDTO class] delegate:self successSelector:@selector(dataLoaded:) failureSelector:nil];

    
	/*NSString *jString = @"{\"currentReading\":[{\"id\":3,\"startDate\":null,\"currentThoughts\":\"holy shit!!!! aesome\",\"book\":{\"id\":3,\"isbn\":12345,\"title\":\"awesome book\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null}},{\"id\":2,\"startDate\":null,\"currentThoughts\":\"this book fuckin sucks\",\"book\":{\"id\":2,\"isbn\":1234,\"title\":\"shitty book\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null}},{\"id\":1,\"startDate\":null,\"currentThoughts\":\"its ok\",\"book\":{\"id\":1,\"isbn\":123,\"title\":\"da book\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null}}],\"finishedReading\":[{\"id\":2,\"startDate\":null,\"currentThoughts\":null,\"book\":{\"id\":5,\"isbn\":12,\"title\":\"comic book\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null},\"finishDate\":1374978370840},{\"id\":1,\"startDate\":null,\"currentThoughts\":null,\"book\":{\"id\":4,\"isbn\":123456,\"title\":\"solutions manual\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":\"http://bks3.books.google.com/books?id=1lK3xA72adAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api\"},\"finishDate\":1374978370839}],\"user\":{\"id\":1,\"username\":\"ray123\"}}";
	NSData *data = [jString dataUsingEncoding:NSUTF8StringEncoding];
	id JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    NSLog(@"JSON %@", JSON);

	UserProfileDTO *dto = [[UserProfileDTO alloc] initWithDictionary:JSON];

	NSLog( @"%@", dto.user.username);

	[self dataLoaded:dto];*/


	[self addReaderNavigationItems];
    
    [self cloudScroll];

}

//Stolen from : http://stackoverflow.com/questions/8790079/animate-infinite-scrolling-of-an-image-in-a-seamless-loop
-(void)cloudScroll {
    UIImage *cloudsImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"collage@2x" ofType:@"jpg"]];
    UIColor *cloudPattern = [UIColor colorWithPatternImage:cloudsImage];
    cloudLayer = [CALayer layer];
    cloudLayer.backgroundColor = cloudPattern.CGColor;
    
    cloudLayer.transform = CATransform3DMakeScale(1, -1, 1);
    
    cloudLayer.anchorPoint = CGPointMake(0, 1);
    
//    CGSize viewSize = backgroundCarousel.frame.size;
    //WHAT THE FUCK THIS IS 0,0. I'm hard coding this shit now
//    CGSize viewSize = backgroundCarousel.frame.size;
    
    CGSize viewSize = CGSizeMake(320, 158);
    cloudLayer.frame = CGRectMake(0, 0, cloudsImage.size.width + viewSize.width, viewSize.height);
    
    [backgroundCarousel.layer addSublayer:cloudLayer];
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(-cloudsImage.size.width, 0);
    cloudLayerAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    cloudLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    cloudLayerAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
    cloudLayerAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
    cloudLayerAnimation.repeatCount = HUGE_VALF;
    cloudLayerAnimation.duration = 18.0;
    [self applyCloudLayerAnimation];
}

- (void)applyCloudLayerAnimation {
    [cloudLayer addAnimation:cloudLayerAnimation forKey:@"position"];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)applicationWillEnterForeground:(NSNotification *)note {
    [self applyCloudLayerAnimation];
}


- (void)dataLoaded:(UserProfileDTO*)dto {
    NSLog(@"%@", dto);

	NSLog(@"%@", dto.user.username);
    
    self.navigationItem.title = dto.user.username;
    
    currentlyReadingDataSource = [[CurrentlyReadingDataSource alloc] initWithReadingItems:dto.currentReading];
    currentlyReadingView.dataSource = currentlyReadingDataSource;
    
    completedReadingDataSource = [[CompletedReadingDataSource alloc] initWithReadingItems:dto.finishedReading];
    completedView.dataSource = completedReadingDataSource;
	completedView.delegate = completedReadingDataSource;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
