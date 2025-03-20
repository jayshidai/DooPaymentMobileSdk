//
//  PayCore.swift
//  payment_ios_sdk
//
//  Created by cailei on 2025/3/15.
//

import Foundation
import Hyperswitch


@objc public class PayCore:NSObject{
    var paymentSession: PaymentSession?
    var params: [String: Any] = [:]
    var handler: PaymentSessionHandler?
    
    
    @objc public  func initSDK(publishableKey: String, customBackendUrl: String? = nil, customParams: [String : Any]? = nil, customLogUrl: String? = nil){
        
        
        if publishableKey.isEmpty == false {
            
            self.params.merge(["publishableKey":publishableKey,"customBackendUrl":customBackendUrl ?? "","customLogUrl":customLogUrl ?? ""], uniquingKeysWith: {_, new in new})
            paymentSession = PaymentSession(publishableKey: publishableKey, customBackendUrl: customBackendUrl, customParams: customParams, customLogUrl: customLogUrl)
        }
        
        
    }
    @objc public func initPaymentSession(paymentIntentClientSecret: String){
        paymentSession?.initPaymentSession(paymentIntentClientSecret: paymentIntentClientSecret)
    }
    
    @objc  public func getCustomerSavedPaymentMethods(result:@escaping (_ result: Any?) -> Void){
        func initSavedPaymentMethodSessionCallback(handler: PaymentSessionHandler)-> Void {
            self.handler = handler
            result(["type": "success", "message": "clientSecret"])
        }
        paymentSession?.getCustomerSavedPaymentMethods(initSavedPaymentMethodSessionCallback)
    }
    
    @objc public func getCustomerSavedPaymentMethodData(result:@escaping (_ result: Any?) -> Void){
        let paymentMethod = handler?.getCustomerDefaultSavedPaymentMethodData()
        switch paymentMethod {
        case let card as Card:
            result(["type": "card", "message": card.toHashMap()])
        case let wallet as Wallet:
            result(["type": "wallet", "message": wallet.toHashMap()])
        case let error as PMError:
            result(["type": "error", "message": error.toHashMap()])
        default:
            result(["type": "error", "message": ["code": "0", "message": "Unknown Error"]])
        }
    }
    
    @objc public func confirmWithCustomerDefaultPaymentMethod(result:@escaping (_ result: Any?) -> Void){
        func resultHandler(_ paymentResult: PaymentResult) {
            switch paymentResult {
            case .completed(let data):
                result(["type": "completed", "message": data])
            case .canceled(let data):
                result(["type": "canceled", "message": data])
            case .failed(let error):
                result(["type": "failed", "message": "\(error)"])
            }
        }
        handler?.confirmWithCustomerDefaultPaymentMethod(resultHandler: resultHandler)
    }
    
    @objc  public func getCustomerLastUsedPaymentMethodData(result:@escaping (_ result: Any?) -> Void){
        let paymentMethod = handler?.getCustomerLastUsedPaymentMethodData()
        switch paymentMethod {
        case let card as Card:
            result(["type": "card", "message": card.toHashMap()])
        case let wallet as Wallet:
            result(["type": "wallet", "message": wallet.toHashMap()])
        case let error as PMError:
            result(["type": "error", "message": error.toHashMap()])
        default:
            result(["type": "error", "message": ["code": "0", "message": "Unknown Error"]])
        }
    }
    
    @objc public func confirmWithCustomerLastUsedPaymentMethod(result:@escaping (_ result: Any?) -> Void){
        func resultHandler(_ paymentResult: PaymentResult) {
            switch paymentResult {
            case .completed(let data):
                result(["type": "completed", "message": data])
            case .canceled(let data):
                result(["type": "canceled", "message": data])
            case .failed(let error):
                result(["type": "failed", "message": "\(error)"])
            }
        }
        handler?.confirmWithCustomerLastUsedPaymentMethod(resultHandler: resultHandler)
    }
    
    @objc public func presentPaymentSheet(result:@escaping (_ result: Any?) -> Void){
        DispatchQueue.main.async {
            guard let vc = RCTPresentedViewController() else {
                result(["type": "failed", "message": "Payment Sheet Initialization Failed"])
                return
            }
            self.paymentSession?.presentPaymentSheetWithParams(viewController: vc, params: self.params, completion: { result2 in
                switch result2 {
                case .completed(let data):
                    result(["type": "completed", "message": data])
                case .failed(let error as NSError):
                    result(["type": "failed", "message": "Payment failed: \(error.userInfo["message"] ?? "Failed")"])
                case .canceled(let data):
                    result(["type": "cancelled", "message": data])
                }
            })
        }
    }
    
}

