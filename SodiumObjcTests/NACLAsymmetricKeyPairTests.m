//
//  NACLAsymmetricKeyPairTests.m
//  libsodium-objc
//
//  Created by Damian Carrillo on 6/11/14.
//  Copyright (c) 2014 TabbedOut. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NACLAsymmetricKeyPair.h"

@interface NACLAsymmetricKeyPairTests : XCTestCase
@end

@implementation NACLAsymmetricKeyPairTests

- (void)assertKeyPairIsValid:(NACLAsymmetricKeyPair *)keyPair
{
    XCTAssertNotNil(keyPair, @"");
    
    XCTAssertNotNil(keyPair.publicKey, @"");
    XCTAssertTrue(keyPair.publicKey.data.length > 0, @"");
    
    XCTAssertNotNil(keyPair.privateKey, @"");
    XCTAssertTrue(keyPair.privateKey.data.length > 0, @"");
}

- (void)testInit_expectSuccess
{
    NACLAsymmetricKeyPair *keyPair = [[NACLAsymmetricKeyPair alloc] init];
    
    [self assertKeyPairIsValid:keyPair];
}

- (void)testInitWithSeed_expectSuccess
{
    NSData *seed = [@"i-am-a-seed. i-am-a-seed. i-am-a-seed." dataUsingEncoding:NSUTF8StringEncoding];
    NSRange seedRange = {0, [NACLAsymmetricKeyPair seedLength]};
    seed = [seed subdataWithRange:seedRange];
    
    NACLAsymmetricKeyPair *keyPair = [[NACLAsymmetricKeyPair alloc] initWithSeed:seed];

    [self assertKeyPairIsValid:keyPair];
}

- (void)testInitWithSeed_withNilSeed
{
    NACLAsymmetricKeyPair *keyPairA = [[NACLAsymmetricKeyPair alloc] init];
    NACLAsymmetricKeyPair *keyPairB = [[NACLAsymmetricKeyPair alloc] initWithSeed:nil];
    
    XCTAssertNotEqual(keyPairA, keyPairB, @"");
    XCTAssertNotEqualObjects(keyPairA.publicKey, keyPairB.publicKey, @"");
    XCTAssertNotEqualObjects(keyPairA.privateKey, keyPairB.privateKey, @"");    
}

- (void)testCreationMethod_expectSuccess
{
    NACLAsymmetricKeyPair *keyPair = [NACLAsymmetricKeyPair keyPair];
    
    [self assertKeyPairIsValid:keyPair];
}

- (void)testCreationMethodWithSeed_expectSuccess
{
    NSData *seed = [@"i-am-a-seed. i-am-a-seed. i-am-a-seed." dataUsingEncoding:NSUTF8StringEncoding];
    NSRange seedRange = {0, [NACLAsymmetricKeyPair seedLength]};
    seed = [seed subdataWithRange:seedRange];
    
    NACLAsymmetricKeyPair *keyPair = [NACLAsymmetricKeyPair keyPairWithSeed:seed];

    [self assertKeyPairIsValid:keyPair];
}

- (void)testCopy
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    NACLAsymmetricKeyPair *keyPairB = [keyPairA copy];
    
    XCTAssertNotEqual(keyPairA, keyPairB, @"");
    XCTAssertEqualObjects(keyPairA.publicKey, keyPairB.publicKey, @"");
    XCTAssertEqualObjects(keyPairA.privateKey, keyPairB.privateKey, @"");
}

- (void)testIsEqual_whenEqual
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    NACLAsymmetricKeyPair *keyPairB = [keyPairA copy];
    
    XCTAssertTrue([keyPairA isEqual:keyPairB], @"");
    XCTAssertTrue([keyPairB isEqual:keyPairA], @"");
}

- (void)testIsEqual_withSelf
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    
    XCTAssertTrue([keyPairA isEqual:keyPairA], @"");
    XCTAssertTrue([keyPairA isEqual:keyPairA], @"");
}

- (void)testIsEqual_whenNotEqual
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    NACLAsymmetricKeyPair *keyPairB = [NACLAsymmetricKeyPair keyPair];
    
    XCTAssertFalse([keyPairA isEqual:keyPairB], @"");
    XCTAssertFalse([keyPairB isEqual:keyPairA], @"");
}

- (void)testIsEqual_withNil
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];

    XCTAssertFalse([keyPairA isEqual:nil], @"");
}

- (void)testIsEqual_withDifferentClass
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    
    XCTAssertFalse([keyPairA isEqual:@"something"], @"");
}

- (void)testIsEqualToKeyPair_whenEqual
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    NACLAsymmetricKeyPair *keyPairB = [keyPairA copy];
    
    XCTAssertTrue([keyPairA isEqualToKeyPair:keyPairB], @"");
    XCTAssertTrue([keyPairB isEqualToKeyPair:keyPairA], @"");
}

- (void)testIsEqualToKeyPair_withSelf
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    
    XCTAssertTrue([keyPairA isEqualToKeyPair:keyPairA], @"");
    XCTAssertTrue([keyPairA isEqualToKeyPair:keyPairA], @"");
}

- (void)testIsEqualToKeyPair_whenNotEqual
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    NACLAsymmetricKeyPair *keyPairB = [NACLAsymmetricKeyPair keyPair];
    
    XCTAssertFalse([keyPairA isEqualToKeyPair:keyPairB], @"");
    XCTAssertFalse([keyPairB isEqualToKeyPair:keyPairA], @"");
}

- (void)testHash_withEqualKeypairs
{
    NACLAsymmetricKeyPair *keyPairA = [NACLAsymmetricKeyPair keyPair];
    NACLAsymmetricKeyPair *keyPairB = [keyPairA copy];
    
    XCTAssertEqual([keyPairA hash], [keyPairB hash], @"");
    XCTAssertEqual([keyPairB hash], [keyPairA hash], @"");
}

- (void)testArchival
{
    NACLAsymmetricKeyPair *keyPair = [NACLAsymmetricKeyPair keyPair];
    NSData *encodedKeyPair = [NSKeyedArchiver archivedDataWithRootObject:keyPair];
    
    XCTAssertTrue(encodedKeyPair.length > 0, @"");
}

- (void)testUnarchival
{
    NACLAsymmetricKeyPair *keyPair = [NACLAsymmetricKeyPair keyPair];
    NSData *encodedKeyPair = [NSKeyedArchiver archivedDataWithRootObject:keyPair];
    NACLAsymmetricKeyPair *decodedKeyPair = [NSKeyedUnarchiver unarchiveObjectWithData:encodedKeyPair];
    
    XCTAssertTrue([keyPair isEqualToKeyPair:decodedKeyPair], @"");
}

- (void)testDescription
{
    NACLAsymmetricKeyPair *keyPair = [NACLAsymmetricKeyPair keyPair];
    XCTAssertTrue([[keyPair description] length] > 0, @"");
}

@end
