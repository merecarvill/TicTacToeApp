import Foundation

public class AsyncHttpClient: HttpClient {

    public func makeRequest(
        url: String,
        successHandler: (String) -> Void,
        failureHandler: () -> Void
        ) {
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: NSURL(string: url)!)

        session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error == nil && data != nil {
                        let reply = String(data: data!, encoding: NSUTF8StringEncoding)
                        successHandler(reply!)
                } else {
                    failureHandler()
                }
            })
        }.resume()
    }
}