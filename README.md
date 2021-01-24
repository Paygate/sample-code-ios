# sample-code-ios
## PayGate Sample Code iOS

The below example code and testing interface has been provided.

## Installation
[![PayGate Sample Code for iOS](https://appinlet.com/wp-content/uploads/2021/01/PayGate-Sample-Code-for-iOS.jpg)](https://www.youtube.com/watch?v=XedrmwIb1RI "PayGate Sample Code for iOS")

To generate the needed dependencies, run the following from your project directory:

```bash
sudo gem install cocoapods # install CocoaPods library (ignore if already installed)
pod install # install CocoaPods specific to this project
pod update # update CocoaPods specific to this project
```

## PayHost

[PayHost](https://www.paygate.co.za/paygate-products/payhost/) is [PayGate’s](https://www.paygate.co.za/) enterprise API which offers a powerful, flexible payment processing interface with many possible applications such as e-commerce, mobile payments, recurring payments and call centre payments but is not limited to these applications. Payments can be processed either via a host-to-host integration or redirected to a PayGate-hosted payments page, and a number of international and regional payment methods are supported.

**SinglePayment**
- CardPayment
- WebPayment
- TokenPayment

**SingleFollowup**
- Query
- Void
- Settlement
- Refund

**SingleVault**
- CardVault
- DeleteVault
- LookupVault
