//
//  BlueTool.m
//  BlueTool
//
//  Created by 智恒创 on 15/7/31.
//  Copyright (c) 2015年 zhc. All rights reserved.
//

// 自定义Log
#ifdef DEBUG // 调试
#define MyLog(...) NSLog(__VA_ARGS__)
#else // 发布打包
#define MyLog(...)
#endif

#import "BlueTool.h"
#import "MBProgressHUD+Show.h"



#define KNAME @"D013A"



static eventBlock privateStatusBlock;
static valueBlock privateValueBlock;

@interface BlueTool()<CBCentralManagerDelegate,CBPeripheralDelegate>{
    
    NSMutableArray *_writeCharacteristics;   //占时储存拥有写的特性（在查看特性方法中）
    NSMutableArray *_notiCharacteristics;    //占时储存拥有通知的特性（在查看特性方法中）
    NSMutableArray *_readCharacteristics;    //占时储存拥有读的特性（在查看特性方法中）
    
    
    
    NSTimer *_rrsiTime;
}
@property(nonatomic,strong)CBCentralManager *manager;

@end

@implementation BlueTool

singleton_implementation(BlueTool);




-(id)init{

    if (self = [super init]) {
        if (_manager == nil) {
            _manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
        }
        
        if (_allPer == nil) {
            _allPer = [NSMutableDictionary dictionary];
            _allRISS = [NSMutableDictionary dictionary];
            
            _writeCharacteristics = [NSMutableArray array];
            _notiCharacteristics = [NSMutableArray array];
            _readCharacteristics = [NSMutableArray array];
            
            //前一次连接的设备UUID
            _lastDevUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastDevUUID"];
        }
    }
    return self;
}

#pragma mark -硬件响应

-(void)hardwareResponseStatus:(eventBlock)block{
    privateStatusBlock = [block copy];
}

-(void)hardwareResponseValue:(valueBlock)block{
    privateValueBlock = [block copy];
}


#pragma mark - 扫描

-(void)stopScan{
    [_manager stopScan];
}


-(void)startScan{

    [_manager stopScan];
    
    //检索当前连接的所有设备 可能是自己需要的外设
    
    NSArray *servicesUUID = [_characteristics allValues];
    NSMutableArray *services = [NSMutableArray array];
    
    for (int i = 0; i < servicesUUID.count; i++) {
        CBUUID *UUID = [CBUUID UUIDWithString:servicesUUID[i]];
        [services addObject:UUID];
    }
    
    NSArray *peripherals = [_manager retrieveConnectedPeripheralsWithServices:services];
    
    for (CBPeripheral *per in peripherals) {
        if (per != _pre) [_manager cancelPeripheralConnection:per];  //断开现在连接的外设
    }
    
//   [_manager retrieveConnectedPeripherals]; //检索当前连接的所有设备  iOS9之后不能用了
//   NSDictionary * dic = @{CBCentralManagerScanOptionAllowDuplicatesKey:@NO};
    [_manager scanForPeripheralsWithServices:nil options:nil];
}



#pragma mark 中心状态更新 1

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state == CBCentralManagerStatePoweredOn) {
        _isOn = YES;
    }else{
        _isOn = NO;
        
        [self stopScan];
        
    }
    
}

#pragma mark 中心开始扫描 2

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    MyLog(@"NAME =  %@  identifier = %@",peripheral.name, [peripheral.identifier  UUIDString]);
    
    //搜索到的设备
    
    if ([peripheral.name isEqualToString:KNAME]) {    //过滤设备
        
        [_allPer setObject:peripheral forKey:peripheral.identifier.UUIDString];
        privateStatusBlock(peripheral,STATUS_UPDATEPRE);
        
        
        if (_allRISS.count) {
            
            int lastvalue = [_allRISS.allValues.lastObject intValue];
            int value = [RSSI intValue];
            
            if (value > lastvalue) {
                [_allRISS setObject:RSSI forKey:peripheral.identifier.UUIDString];
            }
            
        }else{
        
            [_allRISS setObject:RSSI forKey:peripheral.identifier.UUIDString];
        }
        
        
        if (_lastDevUUID) {
            [[BlueTool sharedBlueTool] connectingADevice:_lastDevUUID];
        }
        
    }
    
    
    
}

#pragma mark - 取消连接

- (void)cancelPeripheralConnection{
    
    if (_pre && (_pre.state == CBPeripheralStateConnected) /*_pre.isConnected*/) {
        [_manager cancelPeripheralConnection:_pre];
        _pre = nil;
        _pre.delegate = nil;
    }
}

#pragma mark 外界连接一个设备 3

-(void)connectingADevice:(NSString *)UUID{

//    [_manager stopScan];
    
    BOOL isConnected = _pre && (_pre.state == CBPeripheralStateConnected) /*_pre.isConnected*/;
    if (isConnected && [_pre.identifier.UUIDString isEqualToString:UUID]) {
        [_pre setDelegate:self];
        [_pre discoverServices:nil];
        return;
    }
    
    if (isConnected) {
        [_manager cancelPeripheralConnection:_pre];
        _pre = nil;
    }
    
    CBPeripheral *per = _allPer[UUID];
    if (per) {
        
        [_manager connectPeripheral:per options:nil];
        
        //开启指示器
        UIView *window = [UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.labelText = @"正在连接";
        hud.removeFromSuperViewOnHide = YES;
        [self performSelector:@selector(afterDelay:) withObject:hud afterDelay:10];
        
    }else{
    
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"lastDevUUID"];
    }
    
}

-(void)afterDelay:(MBProgressHUD *)hud{
    [hud hide:YES];
}

#pragma mark- 连接成功  4

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{

    _pre = peripheral;
    privateStatusBlock(_pre,STATUS_CONNECTED);
    
    UIView *window = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
    [MBProgressHUD showSuccessWithText:@"连接成功"];
    
    _lastDevUUID = _pre.identifier.UUIDString;
    [[NSUserDefaults standardUserDefaults] setObject:_pre.identifier.UUIDString forKey:@"lastDevUUID"];
    
    
    [_pre setDelegate:self];
    [_pre discoverServices:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (_rrsiTime) {
            [_rrsiTime invalidate];
            _rrsiTime = nil;
        }
        _rrsiTime = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(readRSSI:) userInfo:nil repeats:YES];
    });
    
    
}

#pragma mark readRSSI 定时器
-(void)readRSSI:(NSTimer *)timer{
    if (_pre)[_pre readRSSI];
}

#pragma mark 断开连接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

    privateStatusBlock(_pre,STATUS_DISCONNECTED);
    [MBProgressHUD showErrorWithText:@"连接断开"];
    
    if (error) MyLog(@"连接断开      %@",error.localizedDescription);
    
    if (_pre) {
        _pre.delegate = nil;
        _pre = nil;
    }
    
    if (_rrsiTime) {
        [_rrsiTime invalidate];
        _rrsiTime = nil;
    }
    
    
    
//    //断开后自动重新连接
//    [[BlueTool sharedBlueTool] connectingADevice:_lastDevUUID];
    
}

#pragma mark 无法连接

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    if (error) MyLog(@"无法连接  %@",error.localizedDescription);
}


#pragma mark 查找服务  5

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        MyLog(@"查找服务      %@",error.localizedDescription);
        return;
    }
    
    NSUInteger count = peripheral.services.count;
    
    for (CBService *serv in peripheral.services) {
        
        MyLog(@"SERVECE_UUID  %@      %ld个", serv.UUID.UUIDString,count);
        
        [_pre discoverCharacteristics:nil forService:serv];
    }
    
}


#pragma mark 查找特性  6

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{

    if (error) {
        MyLog(@"查找特性      %@",error.localizedDescription);
        return;
    }
    
    //过滤需要的服务
//    BOOL isServece = [service.UUID.UUIDString isEqualToString:SERVECE1_UUID] || [service.UUID.UUIDString isEqualToString:SERVECE2_UUID] ||
//    [service.UUID.UUIDString isEqualToString:SERVECE3_UUID];
    
    if (YES){
        for (CBCharacteristic *charca in service.characteristics){
            
            if ([_letWriteUUIDs containsObject:charca.UUID.UUIDString]) {
                
                if (![_writeCharacteristics containsObject:charca]) {  //如果没有包含这个服务
                    [_writeCharacteristics addObject:charca];
                }
            }
            
            if ([_letReadUUIDs containsObject:charca.UUID.UUIDString]) {
                
                if (![_readCharacteristics containsObject:charca]) {  //如果没有包含这个服务
//                    [_readCharacteristics addObject:charca];
                    [_pre readValueForCharacteristic:charca];
                }
            }
            
            if ([_letNotiUUIDs containsObject:charca.UUID.UUIDString]) {
                
                if (![_notiCharacteristics containsObject:charca]) {  //如果没有包含这个服务
                    [_notiCharacteristics addObject:charca];
                    [_pre setNotifyValue:YES forCharacteristic:charca];
                }
            }
            
            MyLog(@"Characteristics.UUID %@  Service.UUID %@ Properties:%ld ",charca.UUID.UUIDString,service.UUID.UUIDString,(unsigned long)charca.properties);
            
//            [_pre readValueForCharacteristic:charca];   //假设所有都读取就能看见数据(用于测试)
            
        }
    }
}

#pragma mark 通知更新

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{

    if (error){
        MyLog(@"通知蓝牙数据更新失败 %@ error %@",characteristic.UUID.UUIDString,error.localizedDescription);
        return;
    }
    
    MyLog(@"通知蓝牙数据更新 %@",characteristic.value);
    
    if ([_notiCharacteristics containsObject:characteristic]) {   //如果包含在通知特性
        if (characteristic.isNotifying) [peripheral readValueForCharacteristic:characteristic];
    }else{
        return;
    }
}

#pragma mark 更新值回调  7

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{

    if (error){
        MyLog(@"读取蓝牙数据失败 %@ error %@",characteristic.UUID.UUIDString,error.localizedDescription);
        return;
    }
    
    NSData *data = characteristic.value;
    if (data.length == 0) return;
    
    if (privateValueBlock) {
        privateValueBlock(peripheral,characteristic,nil);
    }
    
    
    if ([_delegate respondsToSelector:@selector(blueToolPeripheral:didUpdateValueForCharacteristic:)]) {
        [_delegate blueToolPeripheral:peripheral didUpdateValueForCharacteristic:characteristic];
    }
}

#pragma mark 写入蓝牙数据回调

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
   
    
    if (error){
        MyLog(@"写入蓝牙数据失败 %@  %@",characteristic.UUID.UUIDString,[error localizedDescription]);
        return;
    }
}

#pragma mark RSSI

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error{

    if (error){
        MyLog(@"读取RRSI %@",[error localizedDescription]);
        return;
    }
    
    if (privateValueBlock) {
        privateValueBlock(peripheral,nil,RSSI);
    }
    
    
    if ([_delegate respondsToSelector:@selector(blueToolPeripheral:didReadRSSI:)]) {
        [_delegate blueToolPeripheral:peripheral didReadRSSI:RSSI];
    }
}



#pragma mark - 写数据 读  通知

- (BOOL)characteristicUUID:(NSString *)UUID data:(NSData *)data type:(int)type{

    if (_pre == nil) {
//        [MBProgressHUD showErrorWithText:@"请先连接设备"];
        return NO;
    }
    
    for (CBCharacteristic *charca in _writeCharacteristics) {
        if ([charca.UUID.UUIDString isEqualToString:UUID]) {
            
            if(type == 1){
                [_pre readValueForCharacteristic:charca];
            }else if (type == 2){
                
                NSString *s = charca.UUID.UUIDString;
                
                [_pre writeValue:data forCharacteristic:charca type:CBCharacteristicWriteWithResponse];
            }else{
                [_pre setNotifyValue:YES forCharacteristic:charca];
            }
            
        }
    }
    
    return YES;
}

@end
