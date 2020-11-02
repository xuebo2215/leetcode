//
//  ViewController.m
//  leetcode
//
//  Created by 薛波 on 2020/5/26.
//  Copyright © 2020 薛波. All rights reserved.
//

#import "ViewController.h"

static NSMutableDictionary*info;


static inline void FUNCTIONfFINISH(__strong NSArray **strings) {
    CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
    NSString *checkkey = (*strings).firstObject;
    NSString *checkDes = (*strings).lastObject;
    NSLog(@"%@,%@,%f ms,END",checkDes,checkkey,(currentTime - [info[checkkey] doubleValue]) * 1000);
}

static inline void CHECKPOINT_INIT(__strong NSString *key) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       info = [[NSMutableDictionary alloc] init];
    });
    CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
    info[key] = @(currentTime);
    NSLog(@"%@,begin",key);
}

#define CHECK_PERFORMANCE(KEY,ENDDES)  CHECKPOINT_INIT(KEY);\
__strong NSArray *infos __attribute__((cleanup(FUNCTIONfFINISH),unused)) = @[KEY,ENDDES];



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",[self twoSum:@[@2,@3,@5,@9,@4,@1,@22] target:12]);
    NSLog(@"%d",[self closetoSum:@[@-1,@2,@1,@-4] target:1]);

}

- (NSArray*)twoSum:(NSArray<NSNumber*>*)nums target:(NSUInteger)target
{
    NSMutableDictionary *nummap = [NSMutableDictionary new];
    for (NSUInteger index=0; index<nums.count; index++) {
        if ([nummap.allKeys containsObject:@(target-[nums[index] intValue])]) {
            return @[@(index),nummap[@(target-[nums[index] intValue])]];
        }
        nummap[nums[index]] = @(index);
    }
    return @[];
}
/**
 给定一个包括 n 个整数的数组 nums 和 一个目标值 target。找出 nums 中的三个整数，使得它们的和与 target 最接近。返回这三个数的和。假定每组输入只存在唯一答案。

 例如，给定数组 nums = [-1，2，1，-4], 和 target = 1.

 与 target 最接近的三个数的和为 2. (-1 + 2 + 1 = 2).

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/3sum-closest
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
- (int)closetoSum:(NSArray<NSNumber*>*)nums target:(int)target
{
    NSString *des = [NSString stringWithFormat:@"closetoSum:%@target:%d",nums.description,target];
    CHECK_PERFORMANCE(@"closetoSum",des);
    int tsum = 0;
    for (int index=0; index<nums.count; index++) {
        int index_next1 = index+1;
        while (1) {
            if (index_next1>nums.count-2) {
                break;
            }
            int index_next2 = index_next1+1;
            while (1) {
                if (index_next2>nums.count-1) {
                    break;
                }else{
                    int sum = [nums[index] intValue] + [nums[index_next1] intValue]+ [nums[index_next2] intValue];
                    if(sum == target){
                        return sum;
                    }else{
                        tsum==0?tsum=sum:abs(sum-target)<abs(tsum-target)?tsum=sum:tsum=tsum;
                    }
                }
                index_next2++;
            }
            index_next1++;
        }
    }
    return tsum;
}
@end
