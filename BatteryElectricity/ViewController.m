//
//  ViewController.m
//  BatteryElectricity
//
//  Created by 666gps on 2017/6/26.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import "ViewController.h"
#import "ElectricityView.h"

@interface ViewController (){
    ElectricityView * view;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    view = [[ElectricityView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    [self.view addSubview:view];
}

-(void)dealloc{
    [view endTimer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
