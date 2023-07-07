#include "c_example.h"

int binarySearch(int* array, int arraySize, int target) {
    int low = 0;
    int high = arraySize - 1;
    int index = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (array[mid] == target) index = mid;
        else if (array[mid] < target) low = mid + 1;
        else high = mid - 1;

        if (array[mid] == target) break;
    }
    return index;
}

