#import "BaseDTO.h"

@interface CallbackDTO : BaseDTO
{
    NSNumber *apiVersion;

    //To be converted to the appropriate DTOs during callback processing
    NSArray  *responseDTOs;
}

@property (copy) NSNumber *apiVersion;
@property (nonatomic, retain) NSArray *responseDTOs;

// This function tells Jastor what type of class the ResponseDTOs are!
+ (Class)responseDTOs_class;

@end
