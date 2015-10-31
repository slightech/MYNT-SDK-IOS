//
//  STMyntCentralManager.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 15/10/26.
//  Copyright © 2015年 robinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMyntDelegate.h"

@interface STMyntCentralManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  @author Robin, 15-10-31 19:10:27
 *
 *  初始化sdk
 *
 *  @param delegate       回调接口
 */
- (void)installWithDelegate:(id<STMyntCentralDelegate>)delegate;


/**
 *  @author Robin, 15-10-31 19:10:27
 *
 *  初始化sdk
 *
 *  @param delegate       回调接口
 *  @param needReportLost 是否需要
 */
- (void)installWithDelegate:(id<STMyntCentralDelegate>)delegate needReportLost:(BOOL)needReportLost;

@end
