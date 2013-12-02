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

@interface SXGrid : NSObject

@property (readonly) NSUInteger rows;
@property (readonly) NSUInteger cols;

- (id)initWithRows:(NSUInteger)rows cols:(NSUInteger)cols;

- (void)setValue:(id)value forRow:(NSUInteger)row col:(NSUInteger)col;
- (id)valueAtRow:(NSUInteger)row col:(NSUInteger)col;
- (BOOL)isCellSetAtRow:(NSUInteger)row col:(NSUInteger)col;
- (void)display;

- (NSArray *)column:(NSUInteger)columnIndex;
- (NSArray *)allColumns;

@end
