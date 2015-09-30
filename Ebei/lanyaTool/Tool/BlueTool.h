//
//  BlueTool.h
//  BlueTool
//
//  Created by 智恒创 on 15/7/31.
//  Copyright (c) 2015年 zhc. All rights reserved.
//

//主要服务和特性  心率
#define SERVECE1_UUID   @"000056EF-0000-1000-8000-00805F9B34FB"

//主要服务和特性  计步
#define SERVECE2_UUID   @"FEF5"

//主要服务和特性  电量
#define SERVECE3_UUID   @"180F"


//ANCS和特性
#define ANCS_UUID                        @"7905F431-B5CE-4E99-A40F-4B1E122D00D0"
#define NS_UUID                          @"9FBF120D-6301-42D9-8C58-25E699A21DBD"


#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "Singleton.h"

@protocol BlueToolDelegate <NSObject>

@optional
- (void)blueToolPeripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic;
- (void)blueToolPeripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI;
@end


typedef enum{
    STATUS_DISCONNECTED = 0,      //断开连接
    STATUS_CONNECTED = 1,         //连接成功
    STATUS_UPDATEPRE = 2          //扫描出了可见设备
    
}STATUS;


typedef void (^eventBlock)(CBPeripheral *peripheral, STATUS status);
typedef void (^valueBlock)(CBPeripheral *peripheral, CBCharacteristic *charac, NSNumber *RSSI);


@interface BlueTool : NSObject

singleton_interface(BlueTool);

@property (nonatomic, assign) id<BlueToolDelegate> delegate;

@property (nonatomic, strong, readonly) CBPeripheral *pre;            //正在连接的设备
@property (nonatomic, strong, readonly) NSMutableDictionary *allPer;  //目前能见的所有设备 对应的[peripheral.identifier  UUIDString]
@property (nonatomic, strong, readonly) NSMutableDictionary *allRISS; //扫描情况下对应的RISS 值


@property (nonatomic, assign, readonly) BOOL isOn;                    //蓝牙是否可用
@property (nonatomic, copy, readonly) NSString *lastDevUUID;          //上次连接的设备UUID  identifier.UUIDString


- (void)startScan;  //开始扫描
- (void)stopScan;   //停止扫描

- (void)connectingADevice:(NSString *)UUID;// [peripheral.identifier  UUIDString]
- (void)cancelPeripheralConnection;        // 取消连接


- (BOOL)characteristicUUID:(NSString *)UUID data:(NSData *)data type:(int)type; //设置: 读->1 写->2 通知->3 


//响应回调
- (void)hardwareResponseStatus:(eventBlock)block;    //状态响应 一般用于扫描界面
- (void)hardwareResponseValue:(valueBlock)block;     //读值响应 一般用于数据界面  可用代理或者blcok


//开启扫描之前需要设定的
@property (nonatomic, strong) NSDictionary *characteristics;    //一个服务ID 对应的所有特性(CBUUIDs)
@property (nonatomic, strong) NSArray *letWriteUUIDs;           //所有拥有写特性的((CBUUIDs))
@property (nonatomic, strong) NSArray *letNotiUUIDs;            //所有拥有通知特性的((CBUUIDs))
@property (nonatomic, strong) NSArray *letReadUUIDs;            //所有拥有读特性的((CBUUIDs))

@end
