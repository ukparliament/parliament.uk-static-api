# Parliament.uk-static-api

[Parliament.uk-static-api][parliament.uk-static-api] is a Sinatra app created by [Parliamentary Digital Service][parliamentary-digital-service] that provides mock data for the UK Parliament prototype website, which can be called by any application pointing at this API.

[![License][shield-license]][info-license]

> **NOTE:** This API is in active development and is likely to change at short notice. It is not recommended that you use this in any production environment.

## Requirements
[Parliament.uk-static-api][parliament.uk-static-api] requires the following:
* [Ruby][ruby]
* [Bundler][bundler]
* [Sinatra][sinatra]

## Usage
1. Install all required gems by running in your console:
```curl
bundle install
```

2. Ensure [Parliament.uk-static-api][parliament.uk-static-api] is running on port 5000 by running in your terminal:
```curl
bundle exec puma -p 5000
```

3. An application can then call [Parliament.uk-static-api][parliament.uk-static-api] by pointing the application's base URL at the static API. This can be set using environment variables.
```curl
PARLIAMENT_BASE_URL=http://localhost:5000/api/v1
```

4. A static file will be served back to the application, depending on the URL visited. (**Note:** The same response is provided from [Parliament.uk-static-api][parliament.uk-static-api] even when using different IDs. Its purpose is to provide an example of a response from a specific endpoint, not an actual response).


## License
The gem is available as open source under the terms of the [Open Parliament Licence][info-license].

[parliament.uk-static-api]:      https://github.com/ukparliament/parliament.uk-static-api
[parliamentary-digital-service]: https://github.com/ukparliament
[ruby]:                          https://www.ruby-lang.org/en/
[bundler]:                       http://bundler.io/
[rspec]:                         http://rspec.info
[sinatra]:                       http://sinatrarb.com/

[info-license]:   http://www.parliament.uk/site-information/copyright/open-parliament-licence/
[shield-license]: https://img.shields.io/badge/license-Open%20Parliament%20Licence-blue.svg
