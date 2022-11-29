//
//  RequestMaker.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/26/22.
//

import Foundation
import Security

class AdyenTerminalAPI: NSObject {
    let terminal: AdyenTerminal
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init(terminal: AdyenTerminal) {
        self.terminal = terminal

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'" //TODO: FIX THIS, we need either to send UTC time or proper timezon [jl]

        encoder.keyEncodingStrategy = .convertToPascalCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        decoder.keyDecodingStrategy = .convertFromPascalCase
        decoder.dateDecodingStrategy = .formatted(formatter)
    }

    func perform<T:TerminalRequest, R:TerminalResponse>(request: AdyenTerminalRequest<T>) async throws -> AdyenTerminalResponse<R> {
        let encryptor = SaleToPOIMessageSecuredEncryptor()
        let credentials = terminal.encryptionCredentialDetails

        let data = try encoder.encode(request)
        guard let text = String(data: data, encoding: .ascii) else {
            throw AdyenTerminalAPIError.unknown(error: "Error while encoding the payment request")
        }

        print(">>>> REQUEST: \(text)")

        let saleToPOIRequest = try encryptor.encrypt(saleToPOIMessage: text, messageHeader: request.saleToPOIRequest.messageHeader, encryptionCredentialDetails: credentials)
        
        let SaleToPOIRequestSecured = SaleToPOIRequestSecured(saleToPOIRequest: saleToPOIRequest)
        let encodedSaleToPOIRequestSecuredData = try encoder.encode(SaleToPOIRequestSecured)

//        if let logline = String(data: responseData, encoding: .utf8) {
//            print(">>>> RAW RESPONSE: \(logline)")
//        }

        do {
            let responseData = try await self.performRequest(encodedSaleToPOIRequestSecuredData: encodedSaleToPOIRequestSecuredData)
            let securedResponse = try decoder.decode(SaleToPOIResponseSecured.self, from: responseData)
            let response = try encryptor.descrypt(saleToPOIMessageSecured: securedResponse.saleToPOIResponse, encryptionCredentialDetails: credentials)
            print(">>>> Response: \(String(data: response, encoding: .utf8)!)")
            return try decoder.decode(AdyenTerminalResponse.self, from: response)
        } catch {
            if let error = error as? URLError, error.code == .serverCertificateUntrusted {
                throw AdyenTerminalAPIError.serverCertificateUntrusted
            }

            throw error
        }
    }

    private func performRequest(encodedSaleToPOIRequestSecuredData: Data) async throws -> Data {
        let deviceURL = URL(string: "https://\(terminal.ip):8443/nexo")!
        var urlRequest = URLRequest(url: deviceURL)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = encodedSaleToPOIRequestSecuredData
        
        print(">>> request!")
        print(">>> body: \(String(data: encodedSaleToPOIRequestSecuredData, encoding: .utf8)!)")
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: .main)
        let (data, response) = try await urlSession.data(for: urlRequest)
        if let rs = response as? HTTPURLResponse {
            print(">>> response! [\(rs.statusCode)]")
        }
        return data
        
    }
}

///
/// https://stackoverflow.com/questions/34223291/ios-certificate-pinning-with-swift-and-nsurlsession
///
extension AdyenTerminalAPI: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var error: CFError?
                let isServerTrusted = SecTrustEvaluateWithError(serverTrust, &error)
                
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }

                if isServerTrusted {
                    return (URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                } else {
                    let certificateFile = Bundle.main.path(forResource: "adyen-terminalfleet-test", ofType: "crt")
                    guard let certificateFile = certificateFile, let certificateData = NSData(contentsOfFile: certificateFile) as? Data else {
                        return (URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
                    }

                    if let serverCertificates = SecTrustCopyCertificateChain(serverTrust) as? Array<SecCertificate> {
                        for serverCertificate in serverCertificates {
                            let serverCertificateData = SecCertificateCopyData(serverCertificate)
                            let data = CFDataGetBytePtr(serverCertificateData);
                            let size = CFDataGetLength(serverCertificateData);
                            let cert1 = NSData(bytes: data, length: size)

                            var cfName: CFString?
                            SecCertificateCopyCommonName(serverCertificate, &cfName)
                            print(">>> CERTIFICATE: \(cfName.debugDescription)")

                            if cert1.isEqual(to: certificateData) {
                                print("CERTIFICATE IS VALID")
                                return (URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                            } else {
                                print("CERTIFICATE IS NOT VALID")
                            }
                        }
                    }
                }
            }
        }

        // Pinning failed
        return (URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
}
