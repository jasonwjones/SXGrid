//
//  SXCellIndexPath.h
//  Saxbi Cube Viewer
//
//  Created by Jason Jones on 12/5/13.
//  Copyright (c) 2013 Saxifrage Systems LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXGridIndexPath : NSObject

@property (nonatomic, readonly) NSUInteger row;
@property (nonatomic, readonly) NSUInteger col;

+ (id)gridIndexWithRow:(NSUInteger)row col:(NSUInteger)col;

@end
