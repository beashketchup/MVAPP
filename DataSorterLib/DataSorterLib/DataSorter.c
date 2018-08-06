//
//  DataSorter.c
//  MovieFramework
//
//  Created by Buddy on 6/8/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

#include "DataSorter.h"

struct MovieDataStruct* sortElements(struct MovieDataStruct *array, int size)
{
    int i, j;
    struct MovieDataStruct newStruct;
    for (i = 0; i < size - 1; i++)
    {
        for (j = 0; j < (size - 1 - i); j++)
        {
            if (array[j].popularity < array[j + 1].popularity)
            {
                newStruct = array[j];
                array[j] = array[j + 1];
                array[j + 1] = newStruct;
            }
        }
    }
    return array;
}
