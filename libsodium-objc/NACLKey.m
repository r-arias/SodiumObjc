//
//  NACLKey.m
//  libsodium-objc
//
//  Created by Damian Carrillo on 6/13/14.
//  Copyright (c) 2014 TabbedOut. All rights reserved.
//

#import "NACLKey.h"

@interface NACLKey ()
@property (copy, nonatomic, readwrite) NSData *data;
@end

@implementation NACLKey

+ (instancetype)key
{
    NACLKey *__autoreleasing key = [[[self class] alloc] init];
    return key;
}

+ (instancetype)keyWithData:(NSData *)keyData
{
    NACLKey *__autoreleasing key = [[[self class] alloc] initWithData:keyData];
    return key;
}

- (instancetype)init
{
    return [self initWithData:[self generateDefaultKeyData]];
}

- (instancetype)initWithData:(NSData *)keyData
{
    self = [super init];
    
    if (self) {
        _data = [keyData copy];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    
    if (self) {
        _data = [[coder decodeObject] copy];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[[self class] alloc] initWithData:_data];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_data];
}

- (BOOL)isEqual:(id)object
{
    if (object == nil) {
        return NO;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToKey:object];
}

- (BOOL)isEqualToKey:(NACLKey *)key
{
    return [_data isEqualToData:key.data];
}

- (NSUInteger)hash
{
    NSUInteger hash = 1;
    
    hash = 31 * hash + [_data hash];
    
    return hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ {data: %@}", NSStringFromClass([self class]), _data];
}

- (NSData *)generateDefaultKeyData
{
    NSAssert(NO, @"Implement me in a subclass");
    
    return nil;
}

@end