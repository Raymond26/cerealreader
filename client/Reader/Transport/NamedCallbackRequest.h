#import <Foundation/Foundation.h>

/**
 * Object which represents a server request made by the CallbackHandler.
 */
@interface NamedCallbackRequest : NSObject

/// The URL path on the server for the request
@property (strong, nonatomic) NSString *path;

/// Constructs a new instance of the object and sets is path field
+(NamedCallbackRequest*) initWithPath: (NSString*) path;

@end
