//
//  DataStruct.h
//  MovieFramework
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#ifndef DataStruct_h
#define DataStruct_h

#include <stdio.h>

struct MovieDataStruct {
    char *title;
    int popularity;
    char *imageUrl;
};

struct MovieDataStruct* createStruct(const char* title, int popularity, const char* imageUrl);

#endif /* DataStruct_h */
