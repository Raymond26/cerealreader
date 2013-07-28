#import "CallbackDTO.h"
//#import "ResponseDTO.h"

@implementation CallbackDTO

@synthesize apiVersion, responseDTOs;

// This function tells Jastor what type of class the ResponseDTOs are!
+ (Class)responseDTOs_class
{
//    return [ResponseDTO class];
}

@end
