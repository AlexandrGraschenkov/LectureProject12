//
//  ViewController.m
//  AlgoritmsNumberInversion
//
//  Created by Alexander on 06.05.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface TupleArrInt : NSObject
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) long long val;
- (id)initWithArr:(NSArray*)arr val:(long long)val;
@end
@implementation TupleArrInt
- (id)initWithArr:(NSArray*)arr val:(long long)val
{
    self = [super init];
    if(self){
        _arr = arr;
        _val = val;
    }
    return self;
}
@end


@interface ViewController ()
{
    dispatch_queue_t queue1;
    dispatch_queue_t queue2;
}
@property (nonatomic, weak) IBOutlet UILabel *lab1;
@property (nonatomic, weak) IBOutlet UILabel *lab2;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    queue1 = dispatch_queue_create("dsd", 0);
    queue2 = dispatch_queue_create("dsdds", 0);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"IntegerArray" ofType:@"txt"];
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    NSArray *strArr = [str componentsSeparatedByString:@"\r\n"];
    NSMutableArray *numbArr = [[NSMutableArray alloc] initWithCapacity:strArr.count];
    for(NSString *nStr in strArr) {
        NSNumber *num = [nf numberFromString:nStr];
        if(num) {
            [numbArr addObject:num];
        }
    }
    NSArray *arr = [NSArray arrayWithArray:numbArr];
    arr = [arr subarrayWithRange:NSMakeRange(0, 9000)];
    
    dispatch_async(queue1, ^{
        TupleArrInt *result = [self inversionsInArr:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"1: %lld", result.val);
            self.lab1.text = [NSString stringWithFormat:@"%lld", result.val];
        });
    });
    dispatch_async(queue2, ^{
        long long result = [self inversionCount2:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"2: %lld", result);
            self.lab2.text = [NSString stringWithFormat:@"%lld", result];
        });
    });
}

- (TupleArrInt*)inversionsInArr:(NSArray*)arr
{
    if(arr.count <= 1)
        return [[TupleArrInt alloc] initWithArr:arr val:0];
    
    NSInteger len1 = arr.count / 2;
    NSInteger len2 = arr.count - len1;
    TupleArrInt *tup1 = [self inversionsInArr:[arr subarrayWithRange:NSMakeRange(0, len1)]];
    TupleArrInt *tup2 = [self inversionsInArr:[arr subarrayWithRange:NSMakeRange(len1, len2)]];
    
    long long inversionCount = tup1.val + tup2.val;
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
    NSEnumerator *enumerator1 = tup1.arr.objectEnumerator;
    NSEnumerator *enumerator2 = tup2.arr.objectEnumerator;
    
    NSNumber *num1 = [enumerator1 nextObject];
    NSNumber *num2 = [enumerator2 nextObject];
    NSInteger idx1 = 0;
    while (num1 || num2) {
        if(!num1 || (num2 && [num1 compare:num2] == NSOrderedDescending)) {
            [resultArr addObject:num2];
            num2 = [enumerator2 nextObject];
            inversionCount += (long long)(len1 - idx1);
        } else {
            [resultArr addObject:num1];
            num1 = [enumerator1 nextObject];
            idx1++;
        }
    }
    
    NSAssert1(resultArr.count == arr.count, @"WTF%@", @"");
    return [[TupleArrInt alloc] initWithArr:resultArr val:inversionCount];
    NSLog(@"%@", @2);
}

- (long long)inversionCount2:(NSArray*)arr
{
    long long result = 0;
    for(NSInteger i1 = 0; i1 < arr.count; i1++){
        for(NSInteger i2 = i1+1; i2 < arr.count; i2++){
            if([arr[i1] compare:arr[i2]] == NSOrderedDescending)
                result++;
        }
    }
    return result;
}

@end
