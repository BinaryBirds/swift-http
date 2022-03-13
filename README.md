# SwiftHttp

An awesome Swift HTTP library to rapidly create communication layers with API endpoints. 

## Install

You can simply use `SwiftHttp` as a dependency via the Swift Package Manager:

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


## Using raw requests & responses

You can create raw HTTP requests using the HttpUrl and the HttpRawRequest type.   

```swift
let url = HttpUrl(scheme: "https",
                  host: "jsonplaceholder.typicode.com",
                  port: 80,
                  path: ["todos"],
                  resource: nil,
                  query: [:],
                  fragment: nil)

let req = HttpRawRequest(url: url, method: .get, headers: [:], body: nil)

/// execute the request using the client
let client = UrlSessionHttpClient(session: .shared, log: true)
let response = try await client.dataTask(req)

/// use the response data
let todos = try JSONDecoder().decode([Todo].self, from: response.data)
// response.statusCode == .ok
// response.headers -> response headers as a dictionary
``` 

You can use a specific HttpClient to execute a request using a data, download or upload task.


## Constructing URLs

The HttpUrl type allows us to construct various URLs using a base URL. 

```swift

let baseUrl = HttpUrl(host: "jsonplaceholder.typicode.com")

// https://jsonplaceholder.typicode.com/todos/
baseUrl.path("todos")               

// https://jsonplaceholder.typicode.com/todos/1/
baseUrl.path("todos", String(1))    

// https://jsonplaceholder.typicode.com/todos/?foo=bar
baseUrl.path("todos").query("foo", "bar")

// https://jsonplaceholder.typicode.com/todos/?foo=baz&bar=1
baseUrl.path("todos").query([
    "foo": "baz",
    "bar": "1",
])
```

You can transform a HttpUrl object into a Foundation URL by using the `.url` property.

## Requests

You can create a raw request object using a HttpUrl and a HttpMethod, including additional headers and a body data.

```swift
let url = HttpUrl(host: "localhost", path: ["login"])

let token: String = "valid-token"
let body = try JSONEncoder().encode([
    "foo": "bar",
])
let req = HttpRawRequest(url: url,
                         method: .post,
                         headers: [
                            .key(.authorization): "Bearer \(token)",
                            .custom("my-header"): "my-header-value",
                         ],
                         body: body)

/*
curl "https://localhost/login/" \
    -X POST \
    -H 'my-header: my-header-value' \
    -H 'Authorization: Bearer valid-token' \
    -d '{"foo":"bar"}'
*/
print(req.urlRequest.curlString) 
```

You can transform a HttpRequest into a URLReequest via the `.urlRequest` property.
You can print the cURL representation of a request by using the `.curlString` property on a URLRequest object.


## Pipelines

A pipeline allows you to transform a raw request and a raw response using a set of custom actions. 

You can create your own HttpRequestTransformer object to add extra headers to your request and encode a custom body object to a data value.

You can create your own HttpResponseTransformer object to validate the response and decode a custom value from the response data.

The codable (encodable, decodable, codable) pipelines are a good example of this approach.
