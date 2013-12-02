//
//  SXGrid.m
//
//  Created by Jason Jones on 5/13/11.
//  Copyright 2011 Saxifrage Systems LLC. All rights reserved.
//

#import "SXGrid.h"

@interface SXGrid ()

@property (strong, nonatomic) NSMutableArray *data;
@property (readwrite) NSUInteger rows;
@property (readwrite) NSUInteger cols;

@end

@implementation SXGrid

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

- (void)setValue:(id)value forRow:(NSUInteger)row col:(NSUInteger)col
{
    [self.data replaceObjectAtIndex:(row * self.cols + col) withObject:value];
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
    NSLog(@"Grid is %u rows by %u cols", self.rows, self.cols);
    for (NSUInteger row = 0; row < self.rows; row++) {
        for (NSUInteger col = 0; col < self.cols; col++) {
            NSLog(@"Element at (%u, %u): %@", row, col, [self valueAtRow:row col:col]);
        }
    }
}

#pragma mark - Housekeeping

- (NSString *)description
{
    return [NSString stringWithFormat:@"<SSGrid: %d x %d>", self.rows, self.cols];
}

@end
