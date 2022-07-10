//
//  ViewController.m
//  OCSPExample
//
//  Created by 冷秋 on 2022/7/8.
//  Copyright © 2022 冷秋. All rights reserved.
//

#import "ViewController.h"
#import <MUFoundation/MUPath.h>
#import <MobileProvision/MobileProvision.h>
#import <OCSP/OCSP.h>
#import <PKCS12/PKCS12.h>

@interface ViewController ()

@property (nonatomic, strong, readonly) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _btn = [[UIButton alloc] init];
    [_btn setTitle:@"CHECK" forState:UIControlStateNormal];
    _btn.backgroundColor = [UIColor grayColor];
    [_btn addTarget:self action:@selector(onCheck:) forControlEvents:UIControlEventTouchUpInside];
    [_btn sizeToFit];
    [self.view addSubview:_btn];
    _btn.center = self.view.center;
}

- (void)onCheck:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"OCSP"
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"P12"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
        [self checkByP12];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Mobile Provision"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
        [self checkByProvision];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                    style:UIAlertActionStyleCancel
                                                  handler:nil]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)checkByProvision {
    MUPath *file = [[MUPath mainBundlePath] subpathWithComponent:@"profile.mobileprovision"];
    MPProvision *provision = [MPProvision provisionWithContentsOfFile:file.string];
    MPCertificate *certificate = provision.DeveloperCertificates.firstObject;
    NSString *serialNumber = certificate.serialNumber;
    OCSPRequest *request = [OCSPRequest requestWithSerialNumber:serialNumber];
    OCSPSessionManager *session = [OCSPSessionManager manager];
    [session request:request handler:^(OCSPResponse *response, NSError *error) {
        NSLog(@"%@ - %@", certificate.serialNumber, (response.status == OCSPCertificateStatusRevoked) ? @"Revoked" : @"Good");
    }];
}

- (void)checkByP12 {
    MUPath *file = [[MUPath mainBundlePath] subpathWithComponent:@"cert.p12"];
    
    NSError *error = nil;
    P12 *p12 = [P12 p12WithContentsOfFile:file.string password:@"1" error:&error];
    NSString *serialNumber = p12.serialNumber;
    OCSPRequest *request = [OCSPRequest requestWithSerialNumber:serialNumber];
    OCSPSessionManager *manager = [OCSPSessionManager manager];//3901260132866929655
    [manager request:request handler:^(OCSPResponse *response, NSError *error) {
        NSLog(@"%@ - %@", p12.serialNumber, (response.status == OCSPCertificateStatusRevoked) ? @"Revoked" : @"Good");
    }];
}

@end
