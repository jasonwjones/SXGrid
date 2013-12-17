//
//  SXGrid.m
//
//  Created by Jason Jones on 5/13/11.
//  Copyright 2011 Saxifrage Systems LLC. All rights reserved.
//
// TODO: throw error if initializing rows/cols with 0

#import "SXGrid.h"

@interface SXGrid ()

@property (strong, nonatomic) NSMutableArray *data;
@property (readwrite) NSUInteger rows;
@property (readwrite) NSUInteger cols;

@end

@implementation SXGrid


// TODO: Look into using NSPointerArray for holding objects!

+ (instancetype)gridWithRows:(NSUInteger)rows cols:(NSUInteger)cols
{
    return [[[self class] alloc] initWithRows:rows cols:cols];
}

+ (instancetype)gridWithRows:(NSUInteger)rows cols:(NSUInteger)cols fromBlock:(id (^)(NSUInteger row, NSUInteger col))callback
{
    SXGrid *grid = [SXGrid gridWithRows:rows cols:cols];
    if (grid) {
        for (NSUInteger row = 0; row < rows; row++) {
            for (NSUInteger col = 0; col < cols; col++) {
                id value = callback(row, col);
                [grid setValue:value forRow:row col:col];
            }
        }
    }
    return grid;
}

- (id)initWithRows:(NSUInteger)rows cols:(NSUInteger)cols
{
    self = [super init];
    if (self != nil) {                        
        self.data = [NSMutableArray arrayWithCapacity:(rows * cols)];
        for (int i = 0; i < rows * cols; i++) {
            [self.data addObject:[NSNull null]];
        }
        self.rows = rows;
        self.cols = cols;
    }
    return self;
}

- (id)objectAtRow:(NSUInteger)row col:(NSUInteger)col
{
    return nil;
}

- (id)initWithSameSizeAsGrid:(SXGrid *)grid
{
    return [self initWithRows:grid.rows cols:grid.cols];
}

- (void)setValue:(id)value forRow:(NSUInteger)row col:(NSUInteger)col
{
    [self.data replaceObjectAtIndex:(row * self.cols + col) withObject:value ? value : [NSNull null]];
}

/**
 Updated to return nil if the cell is not set. This makes us a little more Cocoish, methinks.
 */
- (id)valueAtRow:(NSUInteger)row col:(NSUInteger)col {
    if ([self isCellSetAtRow:row col:col]) {
        return [self.data objectAtIndex:(row * self.cols + col)];
    } else {
        return nil;
    }
}

/**
 Eventually this should be phased out/incorporated into valueAtRow
 */
- (BOOL)isCellSetAtRow:(NSUInteger)row col:(NSUInteger)col {
    return [self.data objectAtIndex:(row * self.cols + col)] != [NSNull null];
}

/**
 returns an entire column from the grid. Do note that it's not necessarily the height of the 
 table as there can be unset cells, in which case they'll be skipped.
 */
- (NSArray *)column:(NSUInteger)columnIndex
{
    NSMutableArray *column = [NSMutableArray arrayWithCapacity:[self rows]];
    for (NSUInteger rowIndex = 0; rowIndex < [self rows]; rowIndex++) {
        id value = [self valueAtRow:rowIndex col:columnIndex];
        if (value) {
            [column addObject:value];
        }
    }
    return column;
}

- (NSArray *)allColumns
{
    NSMutableArray *columns = [NSMutableArray arrayWithCapacity:[self cols]];
    for (NSUInteger columnIndex = 0; columnIndex < [self cols]; columnIndex++) {
        [columns addObject:[self column:columnIndex]];
    }
    return columns;
}

// TODO: refactor to description
- (void)display {
    NSLog(@"Grid is %lu rows by %lu cols", (unsigned long) self.rows, (unsigned long) self.cols);
    for (NSUInteger row = 0; row < self.rows; row++) {
        for (NSUInteger col = 0; col < self.cols; col++) {
            NSLog(@"Element at (%lu, %lu): %@", (unsigned long) row, (unsigned long) col, [self valueAtRow:row col:col]);
        }
    }
}

// TODO: need display function that takes block to translate value

- (void)walkGridWithCallback:(void (^)(NSUInteger row, NSUInteger col, id value))callback
{
    for (NSUInteger row = 0; row < self.rows; row++) {
        for (NSUInteger col = 0; col < self.cols; col++) {
            callback(row, col, [self valueAtRow:row col:col]);
        }
    }
}

- (SXGrid *)gridByTransforming:(id (^)(id originalValue))transformer
{
    SXGrid *grid = [[SXGrid alloc] initWithSameSizeAsGrid:self];
    [self walkGridWithCallback:^(NSUInteger row, NSUInteger col, id value) {
        [grid setValue:transformer(value) forRow:row col:col];
    }];
    return grid;
}

- (NSString *)stringRepresentation
{
    NSString *stringRep = @"";
    for (NSUInteger row = 0; row < self.rows; row++) {
        for (NSUInteger col = 0; col < self.cols; col++) {
            NSString *text = [NSString stringWithFormat:@"[%10s]", [[self valueAtRow:row col:col] UTF8String]];
            stringRep = [stringRep stringByAppendingString:text];
        }
        stringRep = [stringRep stringByAppendingString:@"\n"];
    }
    return stringRep;
}

#pragma mark - Housekeeping

- (NSString *)description
{
    return [NSString stringWithFormat:@"SXGrid: %lu x %lu", (unsigned long) self.rows, (unsigned long) self.cols];
}

@end
