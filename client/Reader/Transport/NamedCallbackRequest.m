#import "NamedCallbackRequest.h"

@implementation NamedCallbackRequest

+(NamedCallbackRequest*) initWithPath: (NSString*) path
{
    NamedCallbackRequest *result = [NamedCallbackRequest alloc];
    result.path = path;
    return result;
}

@end
