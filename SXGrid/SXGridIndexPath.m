//
//  SXCellIndexPath.m
//  Saxbi Cube Viewer
//
//  Created by Jason Jones on 12/5/13.
//  Copyright (c) 2013 Saxifrage Systems LLC. All rights reserved.
//

#import "SXGridIndexPath.h"

@interface SXGridIndexPath ()

@property (nonatomic, readwrite) NSUInteger row;
@property (nonatomic, readwrite) NSUInteger col;

@end

@implementation SXGridIndexPath

+ (id)gridIndexWithRow:(NSUInteger)row col:(NSUInteger)col
{
    SXGridIndexPath *indexPath = [[SXGridIndexPath alloc] init];
    indexPath.row = row;
    indexPath.col = col;
    return indexPath;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"SXGridIndexPath: row = %lu, col = %lu", (unsigned long) self.row, (unsigned long) self.col];
}

@end
