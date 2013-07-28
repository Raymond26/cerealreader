#import "CallbackHandler.h"
#import "AFNetworking.h"
#import "CallbackDTO.h"

#import "UserProfileDTO.h"
#import "CurrentReadingDTO.h"

@implementation CallbackHandler {

    NSString *urlBase;

    //TODO: To be sent back and forth on each request after login
    NSString *sessionKey;
}


// Singleton
+ (CallbackHandler*)instance
{
    static CallbackHandler *sharedSingleton;

    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[CallbackHandler alloc] init];

        return sharedSingleton;
    }
}

- (id)init
{
    //Grab our callback URL from the build environment
    urlBase = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"APP_CALLBACK_URL"];

    return self;
}

- (void)doRequestWithPath:(NSString *)path params:(NSDictionary *)params expectedDTO:(Class)expectedClass delegate:(id)delegate successSelector:(SEL)successSelector failureSelector:(SEL)failureSelector
{
    
    NSURL *url = [self urlWithPath:path params:params];
    NSLog(@"URL %@", url);
    
    NSURLRequest *callbackRequest = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest: callbackRequest
                                                    success:
     
     ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
		 //NSString *jString = @"{\"currentReading\":[{\"id\":3,\"startDate\":null,\"currentThoughts\":\"holy shit!!!! aesome\",\"book\":{\"id\":3,\"isbn\":12345,\"title\":\"awesome book\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null}},{\"id\":2,\"startDate\":null,\"currentThoughts\":\"this book fuckin sucks\",\"book\":{\"id\":2,\"isbn\":1234,\"title\":\"shitty book\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null}},{\"id\":1,\"startDate\":null,\"currentThoughts\":\"its ok\",\"book\":{\"id\":1,\"isbn\":123,\"title\":\"da book\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null}}],\"finishedReading\":[{\"id\":2,\"startDate\":null,\"currentThoughts\":null,\"book\":{\"id\":5,\"isbn\":12,\"title\":\"comic book\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null},\"finishDate\":1374978370840},{\"id\":1,\"startDate\":null,\"currentThoughts\":null,\"book\":{\"id\":4,\"isbn\":123456,\"title\":\"solutions manual\",\"authors\":null,\"description\":null,\"isbn_10\":null,\"pageCount\":null,\"averageRating\":null,\"ratingsCount\":null,\"thumbnail\":null},\"finishDate\":1374978370839}],\"user\":{\"id\":1,\"username\":\"ray123\"}}";
		 //JSON = [NSJSONSerialization JSONObjectWithData:jString options:nil error:nil];

         NSLog(@"JSON %@", JSON);
         BaseDTO *callbackDTO = [[expectedClass alloc] initWithDictionary:JSON];
         
         if ( successSelector ) {
             [delegate performSelectorOnMainThread: successSelector
                                        withObject: callbackDTO
                                     waitUntilDone: NO];
         }
     }
                                                    failure:
     
     ^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON)
     {
         
         //Get us some better looking errors to log
         if ([[error domain] isEqualToString:@"AFNetworkingErrorDomain"])
         {
             NSString *errorDescription = [[error userInfo] valueForKey:@"NSLocalizedDescription"];
             
             NSString *errorString = [[error userInfo] valueForKey:@"NSLocalizedRecoverySuggestion"];
             
             NSLog(@"An error has occured. JSON: %@\nRequest: %@\nError:%@\n\nServer Response: %@",
                   JSON, request, errorDescription, errorString);
             
             if ( failureSelector ) {
                 [delegate performSelectorOnMainThread: failureSelector
                                            withObject: nil
                                         waitUntilDone: NO];
             }
         }
     }];
    
    [operation start];
}

- (NSURL *)urlWithPath:(NSString *)path params:(NSDictionary *)params
{
    //Build our path
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@%@", urlBase, path];
    
    //Add our authentication params if available
    if ( sessionKey )
    {
        NSMutableDictionary *fullParams = [NSMutableDictionary dictionaryWithDictionary:params];
        [fullParams setObject:sessionKey forKey:@"session"];
        
        params = fullParams;
    }

    //Add parameters to the query
    for (NSString *key in [params allKeys])
    {
        id value = [params valueForKey:key];
        
        //Get the string value of the object and HTTP encode the string
        NSString *encodedValue = [NSString stringWithFormat:@"%@", value];
        
        encodedValue = [encodedValue stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        encodedValue = [encodedValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [urlString appendFormat:@"&%@=%@", key, encodedValue];
    }
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    return url;
}


@end
