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
 *  @author Robin, 15-12-03 18:12:59
 *
 *  <#Description#>
 *
 *  @param delegate
 *  @param restoreIdentifier 状态恢复标示
 */
- (void)installWithDelegate:(id<STMyntCentralDelegate>)delegate restoreIdentifier:(NSString *)restoreIdentifier;

/**
 *  @author Robin, 15-12-03 18:12:18
 *
 *  <#Description#>
 *
 *  @param delegate
 *  @param restoreIdentifier 状态恢复标示
 *  @param needReportLost    是否需要帮助社区寻找
 */
- (void)installWithDelegate:(id<STMyntCentralDelegate>)delegate restoreIdentifier:(NSString *)restoreIdentifier needReportLost:(BOOL)needReportLost;

/**
 *  @author Robin, 15-12-03 19:12:03
 *
 *  清空保存的小觅(清空后不会自动重连)
 */
- (void)cleanStoredMynts;

@end
