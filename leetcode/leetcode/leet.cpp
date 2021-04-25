#include "leet.h"
#include <iostream>
#include <map>
int leet::Solution::removeDuplicates(vector<int>& nums)
{
    map<int, int>nummap;
    vector<int>::iterator numit = nums.begin();
    while (numit!= nums.end()) 	{
        int n = *numit;
        nummap[n]=n;
        numit++;
    }

    vector<int>withoutDup;
    map<int, int>::iterator nmapit = nummap.begin();
    while (nmapit != nummap.end()) {
        withoutDup.push_back(nmapit->first);
        nmapit++;
    }
    return withoutDup.size();
}