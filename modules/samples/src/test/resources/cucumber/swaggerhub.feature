Feature: SwaggerHub REST API

  Background:
    Given the Swagger definition at https://api.swaggerhub.com/apis/swagger-hub/registry-api/1.0.10

  Scenario: Default API Listing
    When a request to searchApis is made
    Then the response is a list of APIs in APIs.json format

  Scenario: Owner API Listing
    When a request to getOwnerApis is made
    And owner is swagger-hub
    Then the response is a list of APIs in APIs.json format

  Scenario: API Version Listing
    When a request to getApiVersions is made
    And owner is swagger-hub
    And api is registry-api
    Then the response is a list of API versions in APIs.json format
    And the response body contains /apis/swagger-hub/registry-api

  Scenario Outline: API Retrieval
    When a request to getDefinition is made
    And owner is <owner>
    And api is <api>
    And version is <version>
    Then a 200 response is returned within 500ms
    And the response type is json
    And the response body contains
    """
    "title":"<title>"
    """
    Examples:
    | owner       | api                   | version  | title                     |
    | swagger-hub | registry-api          | 1.0.10   | SwaggerHub Registry API   |
    | smartbear   | ready-api-testserver  | 1.2.1    | Ready! API TestServer API |