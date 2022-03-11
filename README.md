# SwiftHttp

An awesome Swift HTTP library to rapidly create communication layers with API endpoints. 

## Install

You can simply use `SwiftHtml` as a dependency via the Swift Package Manager:

```swift
.package(url: "https://github.com/binarybirds/swift-http", from: "1.0.0"),
```

Add the `SwiftHttp` product from the `swift-http` package as a dependency to your target:

```swift
.product(name: "SwiftHttp", package: "swift-http"),
```

Import the framework:

```swift
import SwiftHttp
```

That's it.


## Basic usage

It is really easy to setup a communication layer with an API endpoint.

```swift
import SwiftHttp

struct Todo: Codable {
    let id: Int
    let title: String
    let completed: Bool
}

struct TodoApi: HttpCodablePipelineCollection {

    let client: HttpClient = UrlSessionHttpClient(log: true)
    let apiBaseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

    
    func list() async throws -> [Todo] {
        try await decodableRequest(executor: client.dataTask,
                                   url: apiBaseUrl.path("todos"),
                                   method: .get)
    }    
}

// api usage
let todos = try await api.list()

// curl log
// curl "https://jsonplaceholder.typicode.com/todos/"

```

The HttpClient provides the executors to perform data, download or upload tasks.

You can create decodable, encodable, codable or raw request when using a codable pipeline collection.

