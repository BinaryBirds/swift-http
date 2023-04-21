public typealias HttpExecutor<DataType> = (
    (HttpRawRequest<DataType>) async throws -> HttpRawResponse<DataType>
)
