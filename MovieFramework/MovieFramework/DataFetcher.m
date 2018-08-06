//
//  DataFetcher.m
//  MovieFramework
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#import "DataFetcher.h"
#import "Constants.h"
#import "DataSorter.h"

@interface DataFetcher ()

@property (nonatomic, strong, readonly) NSString *apiKey;

typedef void (^DataActionBlock) (NSDictionary *response, NSError *error);

@end

@implementation DataFetcher

+ (id)sharedManager {
    static DataFetcher *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    return self;
}

- (void)initWithAPIkey:(NSString *) key {
    _apiKey = key;
}

- (void)fetchMoviesFor:(NSString *) searchItem handler:(ActionBlock) completion {
    
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    __block NSError *newError = nil;
    
    dispatch_group_enter(group);
    [[DataFetcher sharedManager] fetchMoviesFor:searchItem inYear:@"2017" handler:^(NSDictionary *response, NSError *error) {
        if (response) {
            NSArray *array = [response objectForKey:@"results"];
            if (array) {
                [dataArray addObjectsFromArray:array];
            }
        } else {
            newError = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [[DataFetcher sharedManager] fetchMoviesFor:searchItem inYear:@"2018" handler:^(NSDictionary *response, NSError *error) {
        if (response) {
            NSArray *array = [response objectForKey:@"results"];
            if (array) {
                [dataArray addObjectsFromArray:array];
            }
        } else {
            newError = error;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        if (!newError) {
            completion([[DataFetcher sharedManager] sortDataElements:dataArray], nil);
        }
        else {
            completion(nil, newError);
        }
    });
}

- (void)fetchMoviesFor:(NSString *) searchItem inYear:(NSString *) year handler:(DataActionBlock) completion {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?api_key=%@&language=en-US&query=%@&page=1&include_adult=false&year=%@", BASE_URL, SEARCH_PATH, _apiKey, searchItem, year];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                                    if (!error && httpResponse.statusCode == 200 && data) {
                                                        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];                                                        
                                                        if (!error) {
                                                            completion(responseDict, nil);
                                                        } else {
                                                            completion(nil, error);
                                                        }
                                                    } else {
                                                        NSError* error = [NSError errorWithDomain:@"MovieFramework" code:1090 userInfo:@{NSLocalizedDescriptionKey:@"Not able to retireve data"}];
                                                        completion(nil, error);
                                                    }
                                                    
                                                }];
    [dataTask resume];
}

- (void)getImageFor:(NSString *) imagePath handler:(ImageActionBlock) completion {
    NSString *cachePath = [self getCacheLocation];
    if (cachePath) {
        NSString *newPath = [NSString stringWithFormat:@"%@%@", cachePath, imagePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:newPath]) {
            completion([NSData dataWithContentsOfFile:newPath]);
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", IMAGE_URL, IMAGE_SIZE_500, imagePath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                                        if (!error && httpResponse.statusCode == 200 && data) {
                                                            if (!error) {
                                                                NSString *cachePath = [self getCacheLocation];
                                                                if (cachePath) {
                                                                    NSString *newPath = [NSString stringWithFormat:@"%@%@", cachePath, imagePath];
                                                                    [[DataFetcher sharedManager] deleteFile:newPath];
                                                                    [data writeToFile:newPath atomically:YES];
                                                                }
                                                                completion(data);
                                                            } else {
                                                                completion(nil);
                                                            }
                                                        } else {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                completion(nil);
                                                            });
                                                        }
                                                    });
                                                }];
    [dataTask resume];
}

# pragma mark - Sorting

- (NSArray *)sortDataElements:(NSArray *) dataArray {
    
    int length = (int)dataArray.count;
    struct MovieDataStruct cArray[length];
    
    for (int i = 0; i < length; i++) {
        NSDictionary *dict = [dataArray objectAtIndex:i];
        NSString *title = [dict objectForKey:@"title"];
        NSString *imageUrl = [dict objectForKey:@"poster_path"];
        if(imageUrl == nil || [imageUrl isKindOfClass:[NSNull class]]) {
            imageUrl = @"";
        }
        if(title == nil || [title isKindOfClass:[NSNull class]]) {
            title = @"";
        }
        double popularity = [[dict objectForKey:@"popularity"] doubleValue];
        struct MovieDataStruct *newStruct = createStruct([title UTF8String], popularity, [imageUrl UTF8String]);
        cArray[i] = *newStruct;
    }
    
    struct MovieDataStruct *sortedArray = sortElements(cArray, length);
    
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < length; i++) {
        struct MovieDataStruct *newMovie = &sortedArray[i];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%s", newMovie->title] forKey:@"title"];
        [dict setObject:[NSString stringWithFormat:@"%s", newMovie->imageUrl] forKey:@"posterImageUrl"];
        [dict setObject:[NSNumber numberWithDouble:newMovie->popularity] forKey:@"popularity"];
        [mutArray addObject:dict];
    }
    return mutArray;
}

# pragma mark - Location

- (NSString *) getCacheLocation {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (paths.count > 0) {
        NSString *newPath = [NSString stringWithFormat:@"%@/ImageCache", paths[0]];
        if (![[NSFileManager defaultManager] fileExistsAtPath:newPath]) {
            if ([self makeDirectory:newPath]) {
                return newPath;
            }
        }
    }
    return  NULL;
}

- (BOOL) makeDirectory:(NSString *)path {
    NSError *error = NULL;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:NULL error:&error];
    if (!error) {
        return YES;
    } else {
        return NO;
    }
}

- (void) deleteFile:(NSString *)path {
    NSError *error = NULL;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
}

@end
