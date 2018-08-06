//
//  DataStruct.c
//  MovieFramework
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#include <stdlib.h>
#include <string.h>
#include "DataStruct.h"

struct MovieDataStruct* createStruct(const char* title, int popularity, const char* imageUrl) {
    
    struct MovieDataStruct *newStruct = malloc(sizeof(struct MovieDataStruct));
    if (newStruct) {
        char *titleBuffer = malloc(strlen(title) + 1);
        char *imageBuffer = malloc(strlen(imageUrl) + 1);
        
        newStruct->title = titleBuffer ? strcpy(titleBuffer, title) : titleBuffer;
        newStruct->imageUrl = imageBuffer ? strcpy(imageBuffer, imageUrl) : imageBuffer;        
        newStruct->popularity = popularity;
    }
    return newStruct;
}
