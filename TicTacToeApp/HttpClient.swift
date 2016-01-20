public protocol HttpClient {
    func makeRequest(
        url: String,
        successHandler: (String) -> Void,
        failureHandler: () -> Void
    )
}
