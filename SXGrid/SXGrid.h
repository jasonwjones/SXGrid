//
//  SXGrid.h
//
//  The SXGrid object is meant to simply provide a lightweight data structure for storing a grid
//  of some data. You do not extend this class, you use it in composition in another class
//  that has a grid-like data structure.
//
//  Created by Jason Jones on 8/2/11.
//  Copyright 2011 Saxifrage Systems LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXGridIndexPath.h"

// BIG API CHANGE

@interface SXGrid : NSObject <NSCoding>

- (NSUInteger)rows;
- (NSUInteger)cols;
- (id)objectAtRow:(NSUInteger)row col:(NSUInteger)col;

@end

@interface SXGrid (SXExtendedGrid)

+ (instancetype)gridWithRows:(NSUInteger)rows cols:(NSUInteger)cols;
+ (instancetype)gridWithRows:(NSUInteger)rows cols:(NSUInteger)cols fromBlock:(id (^)(NSUInteger row, NSUInteger col))callback;

- (id)initWithRows:(NSUInteger)rows cols:(NSUInteger)cols;

- (void)setValue:(id)value forRow:(NSUInteger)row col:(NSUInteger)col;
- (id)valueAtRow:(NSUInteger)row col:(NSUInteger)col;
- (BOOL)isCellSetAtRow:(NSUInteger)row col:(NSUInteger)col;
- (void)display;

- (NSArray *)column:(NSUInteger)columnIndex;
- (NSArray *)allColumns;

- (NSString *)stringRepresentation;

- (void)walkGridWithCallback:(void (^)(NSUInteger row, NSUInteger col, id value))callback;
- (SXGrid *)gridByTransforming:(id (^)(id originalValue))transformer;

@end
