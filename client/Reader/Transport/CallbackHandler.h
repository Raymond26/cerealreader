
#import <Foundation/Foundation.h>

/**
 * Performs server requests. This class should be updated any time a
 * new server interaction (URL request/DTO response) is defined.
 */
@interface CallbackHandler : NSObject

/// Returns singleton instance of the class
+ (CallbackHandler*) instance;

/**
 * Performs a named server request and will call the specified delegate on the
 * specified success and failure selectors respectively once the server responds.
 * 
 * The requestName parameter should match one of the string constants defined by
 * this class.
 */
- (void)doRequestWithPath:(NSString *)path params:(NSDictionary *)params expectedDTO:(Class)expectedClass delegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector;

@end