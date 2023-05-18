# Changelog

## 1.0.0 (2023-05-11)


### ⚠ BREAKING CHANGES

* use shared database for users and sessions

### Features

* group search results by collection by default ([c10ab81](https://github.com/nla/nla-arclight/commit/c10ab8196ca06dd7ba23e5333b9b5dc6b679ee57))
* integrate catalogue-patrons ([72ebcc6](https://github.com/nla/nla-arclight/commit/72ebcc6b4cd3c394dc2061120fd4dfc96fe051c2))
* integrate separate staff login realms ([f7babf2](https://github.com/nla/nla-arclight/commit/f7babf2056a47acb2d87d42080ace293a64ed23c))
* integrate staff backchannel logout changes ([4074a5e](https://github.com/nla/nla-arclight/commit/4074a5ea08bdffe07fa91b2095d76bb244b1581b))
* move caching from file system to Redis ([808321c](https://github.com/nla/nla-arclight/commit/808321c38cec92f42c3cce2edd82338e8b5de5bf))
* put login link behind feature flag ([29e318d](https://github.com/nla/nla-arclight/commit/29e318d66edb58f6ae5b99cfec3c673f5ca38c40))
* remove "History" navbar link ([4c6a4b6](https://github.com/nla/nla-arclight/commit/4c6a4b63c869f17c80b2762ac1254c2432a83511))
* use shared database for users and sessions ([945cc78](https://github.com/nla/nla-arclight/commit/945cc786aedfe4df5db560e999d901773088065d))


### Bug Fixes

* add keycloak config to sample dev config ([c444e2b](https://github.com/nla/nla-arclight/commit/c444e2bd68a307ea694735da63c99db5ad4a0a01))
* disallow access to blacklight-test.nla.gov.au ([58212db](https://github.com/nla/nla-arclight/commit/58212db4a2d40861dc4943de466c9fbd71fdb371))
* enable arclight transaction log ([ebcdecb](https://github.com/nla/nla-arclight/commit/ebcdecb928967dea483a548c30c5087cdce0c982))
* fixes vendor/bundle permissions on deployment ([2c99235](https://github.com/nla/nla-arclight/commit/2c992354aab68adc565200499a2c0bb03b442e59))
* move responsiveTruncator.js so it overrides the ArcLight version ([dc67f30](https://github.com/nla/nla-arclight/commit/dc67f309a8f47dc6aa9ff38c61c758b23f30a965))
* patch responsiveTruncator.js ([e3618e5](https://github.com/nla/nla-arclight/commit/e3618e53510203f0c346c5680d728b9a090cd29a))
* put flipper UI endpoint within finding-aids scope ([13a439e](https://github.com/nla/nla-arclight/commit/13a439e3ccb2268c4e180ed1dc984c602fba9c36))
* remove deprecated BlacklightRangeLimit::ViewHelperOverride ([8ea65df](https://github.com/nla/nla-arclight/commit/8ea65dfda23547843e48e952ef057d0ee3a700e4))


### Tests

* convert cucumber tests to rspec ([4574921](https://github.com/nla/nla-arclight/commit/4574921f8925ea85dbe23a075d4247eb682a2ef0))
* fixes authentication Cucumber test ([1febf18](https://github.com/nla/nla-arclight/commit/1febf18b73da4203bbbbbf0d2bc95166d609c85f))


### Build System

* make sure `main` branch is using a released `catalogue-patrons` version ([b8a93e3](https://github.com/nla/nla-arclight/commit/b8a93e38aa56ed9ca10f01d243a6b24021f7f480))
* update dependencies in Gemfile with upgrade to 3.2.0 ([6cf9abd](https://github.com/nla/nla-arclight/commit/6cf9abd4d96b81b55e385f0be3bdce16a83a031f))


### Continuous Integration

* adds PATRONS_DB_URL env variable to verify workflow ([4baa13a](https://github.com/nla/nla-arclight/commit/4baa13a55cc1ee129aa21a6b139611738597bb8f))
* adds release workflow ([3f10d2b](https://github.com/nla/nla-arclight/commit/3f10d2bdccf7eda70369ef078140655e3f1cac3d))
* change coverage threshold ([c421263](https://github.com/nla/nla-arclight/commit/c421263b36f30c263651ffadd9b8b6c1f80d874e))
* fixes tests and bumps nokogiri ([4fe0486](https://github.com/nla/nla-arclight/commit/4fe0486c1a9d304be62e0b46d67644c0f72fc429))
* fixes verify workflow ([da4b612](https://github.com/nla/nla-arclight/commit/da4b612699ef1d5c0dec2e0c46c31722f01d8fb0))
* modify config for GALC URL ([7b789a5](https://github.com/nla/nla-arclight/commit/7b789a503e390aed4a9006e8abed2bb01ddbc69c))
* modify versioning in release workflow ([392fca4](https://github.com/nla/nla-arclight/commit/392fca445a92f0da8d604d7e322bb2147cc596a3))
* update Ruby versions in verify workflow ([c170923](https://github.com/nla/nla-arclight/commit/c17092313832356b2ed240df607f9de20752209d))
* update verify workflow to match Blacklight ([cd604b7](https://github.com/nla/nla-arclight/commit/cd604b7e41015e297de05d94473929bafde0b216))


### Documentation

* update build status badge in README.md ([3ea1c21](https://github.com/nla/nla-arclight/commit/3ea1c21547f5c6690959f66c91ac020c4030da38))
* update README.md ([f7db21c](https://github.com/nla/nla-arclight/commit/f7db21cc955dbccf740758acae7fc788a4d84e3e))
* updates README.md ([98c2dab](https://github.com/nla/nla-arclight/commit/98c2dab3d1ac638c22d229ffc1c3d3b2e2cfb796))


### Code Refactoring

* integrate reimplementation of feature flags and location checking ([75f9467](https://github.com/nla/nla-arclight/commit/75f946732b5b7b3678951a070240c783cb875b9d))
* set default User-Agent for Faraday requests ([fc55d24](https://github.com/nla/nla-arclight/commit/fc55d24825f1849de8b46cf6e83fab176e419fdc))


### Miscellaneous

* address CVE-2022-23517 CVE-2022-23518 CVE-2022-23519 CVE-2022-23520 ([4856aa2](https://github.com/nla/nla-arclight/commit/4856aa2e863564bcb225ccaf949dec0e3ba99854))
* bump version of Bundler in Gemfile.lock ([470f4c7](https://github.com/nla/nla-arclight/commit/470f4c710aa240298826945583cac6403d7ea4f9))
* configure as per Blacklight ([0470804](https://github.com/nla/nla-arclight/commit/0470804cb927d50911297a394dd3c26c77c707b5))
* configure solr adapter via env variable ([4b8734f](https://github.com/nla/nla-arclight/commit/4b8734ff0607007ff44fbe06a5c01ecb6d09c346))
* **deps-dev:** bump capybara from 3.37.1 to 3.38.0 ([aa650a4](https://github.com/nla/nla-arclight/commit/aa650a43d0867aa1226a5cc0a5be38a9ce918e4e))
* **deps-dev:** bump cucumber-rails from 2.5.1 to 2.6.0 ([7ba82de](https://github.com/nla/nla-arclight/commit/7ba82de570ab4e39da2da1346e2bf344f3236f50))
* **deps-dev:** bump cucumber-rails from 2.6.0 to 2.6.1 ([d0430fa](https://github.com/nla/nla-arclight/commit/d0430fa3c11e5e1c94ba5f0baf4e4e9414f8aa8f))
* **deps-dev:** bump debug from 1.6.2 to 1.6.3 ([045a652](https://github.com/nla/nla-arclight/commit/045a65281e4ddc6c91a68c3ebfde7ea38f23db97))
* **deps-dev:** bump debug from 1.6.3 to 1.7.0 ([2a478e3](https://github.com/nla/nla-arclight/commit/2a478e3081f40ed1856374bc73689e867068bc03))
* **deps-dev:** bump faker from 2.23.0 to 3.0.0 ([9b3610a](https://github.com/nla/nla-arclight/commit/9b3610a95ac64be720b9dbe5ca389b786edd43bd))
* **deps-dev:** bump rspec-rails from 5.1.2 to 6.0.0 ([d6a9801](https://github.com/nla/nla-arclight/commit/d6a9801d92ba887ef407a21a294985231d8df344))
* **deps-dev:** bump rspec-rails from 6.0.0 to 6.0.1 ([3ffd7ef](https://github.com/nla/nla-arclight/commit/3ffd7efb9254ed6bbba26e711fbd40bf733f118e))
* **deps-dev:** bump rubocop-rails from 2.16.1 to 2.17.1 ([b226a1a](https://github.com/nla/nla-arclight/commit/b226a1ac1b506653cae759d560701dc76956bdcc))
* **deps-dev:** bump rubocop-rails from 2.17.1 to 2.17.2 ([b269931](https://github.com/nla/nla-arclight/commit/b269931aee4ada28b45a3f917141a94ea703fb92))
* **deps-dev:** bump rubocop-rails from 2.17.2 to 2.17.3 ([bc39a0a](https://github.com/nla/nla-arclight/commit/bc39a0a3a539521f1f1a50a54acc6325701f00e5))
* **deps-dev:** bump rubocop-rails from 2.17.3 to 2.17.4 ([41f7e9f](https://github.com/nla/nla-arclight/commit/41f7e9f6b8efa1f3ff602ec5e593ef0a498da7f2))
* **deps-dev:** bump rubocop-rspec from 2.13.2 to 2.14.1 ([aa63183](https://github.com/nla/nla-arclight/commit/aa63183eda65cb56e5858f577b4d626b098a5958))
* **deps-dev:** bump rubocop-rspec from 2.14.1 to 2.14.2 ([3b77ab7](https://github.com/nla/nla-arclight/commit/3b77ab75cf8cfdb6d30b98e3e03ceff2dc052690))
* **deps-dev:** bump rubocop-rspec from 2.14.2 to 2.15.0 ([b7317fa](https://github.com/nla/nla-arclight/commit/b7317fa343e2a2e41296af5ae310cab5abd4d03a))
* **deps-dev:** bump rubocop-rspec from 2.15.0 to 2.16.0 ([9c0865e](https://github.com/nla/nla-arclight/commit/9c0865e951da193be027c7b5de248c4b5a03505d))
* **deps-dev:** bump rubocop-rspec from 2.18.0 to 2.18.1 ([0bf8a01](https://github.com/nla/nla-arclight/commit/0bf8a014627542dc86d12075a5bbbd802299b335))
* **deps-dev:** bump selenium-webdriver from 4.4.0 to 4.5.0 ([7e69e6b](https://github.com/nla/nla-arclight/commit/7e69e6b94256d15412d7c80fc8ee24a024e56acd))
* **deps-dev:** bump selenium-webdriver from 4.5.0 to 4.6.1 ([96d09f8](https://github.com/nla/nla-arclight/commit/96d09f880e7786d2b0fe88cecccd9dc5cc0c8782))
* **deps-dev:** bump selenium-webdriver from 4.6.1 to 4.7.1 ([9c12ce9](https://github.com/nla/nla-arclight/commit/9c12ce97ef283f60236cffe685409161e1549e87))
* **deps-dev:** bump shoulda-matchers from 5.2.0 to 5.3.0 ([ff405af](https://github.com/nla/nla-arclight/commit/ff405af957249fd4c2a955e36657ee38ee8936da))
* **deps-dev:** bump simplecov from 0.21.2 to 0.22.0 ([07a75df](https://github.com/nla/nla-arclight/commit/07a75df87bed9d0ef9e1b346303260e582261f38))
* **deps-dev:** bump standard from 1.16.1 to 1.18.0 ([877d0a0](https://github.com/nla/nla-arclight/commit/877d0a05e9da93e7a789075e8b1caa29ac52884f))
* **deps-dev:** bump standard from 1.18.0 to 1.18.1 ([3f93cbd](https://github.com/nla/nla-arclight/commit/3f93cbd17be90ae9641d94ddf6bcdfe8e43df81a))
* **deps-dev:** bump standard from 1.18.1 to 1.19.1 ([cd9e32a](https://github.com/nla/nla-arclight/commit/cd9e32a365bd5924378bb9230b940035d348b68e))
* **deps-dev:** bump standard from 1.19.1 to 1.21.1 ([98760b1](https://github.com/nla/nla-arclight/commit/98760b1ba3fc040dfded56404b5e307fbfa6c057))
* **deps-dev:** bump standard from 1.22.0 to 1.22.1 ([0a2b122](https://github.com/nla/nla-arclight/commit/0a2b12202bd1c7103df4a0aaf628399311daf44d))
* **deps-dev:** bump webdrivers from 5.1.0 to 5.2.0 ([c059040](https://github.com/nla/nla-arclight/commit/c05904020b6a5ed76627e3a6c7bd80ec5a5b568b))
* **deps:** bump @babel/core from 7.19.1 to 7.19.3 ([eca2b81](https://github.com/nla/nla-arclight/commit/eca2b818684fb563405a0aa5664dccbac492e1c2))
* **deps:** bump @babel/core from 7.19.3 to 7.19.6 ([838c4b7](https://github.com/nla/nla-arclight/commit/838c4b7e3873e8007a1b4a65184c4d375cb1cc47))
* **deps:** bump @babel/core from 7.19.6 to 7.20.2 ([f364015](https://github.com/nla/nla-arclight/commit/f3640150b427f400deb209e14b9218c36ca414ed))
* **deps:** bump @babel/core from 7.20.12 to 7.21.0 ([95e7693](https://github.com/nla/nla-arclight/commit/95e7693eb20f69854aeec60a70a342d0d3c3aa2e))
* **deps:** bump @babel/core from 7.20.2 to 7.20.5 ([831429d](https://github.com/nla/nla-arclight/commit/831429d66d95da8a4f535b5a4a15b801eece85e4))
* **deps:** bump @babel/core from 7.20.5 to 7.20.12 ([9956aaa](https://github.com/nla/nla-arclight/commit/9956aaa60a76b8804ec97db98d8c9cac447527ee))
* **deps:** bump @babel/preset-env from 7.19.1 to 7.19.4 ([37c2587](https://github.com/nla/nla-arclight/commit/37c2587ac1dbcd2a862b1fa4f56ab35db301903e))
* **deps:** bump @babel/preset-env from 7.19.4 to 7.20.2 ([209a092](https://github.com/nla/nla-arclight/commit/209a0923facf769928b0a46579a3504796562645))
* **deps:** bump blacklight_range_limit from 7.9.1 to 8.2.3 ([86ad1ea](https://github.com/nla/nla-arclight/commit/86ad1ea68c8da69d0beff54aef0a8765c6a49510))
* **deps:** bump blacklight-locale_picker from 0.4.0 to 1.0.0 ([c2da2ed](https://github.com/nla/nla-arclight/commit/c2da2edb19670aee0cd6f7b9390ac1b25807fd37))
* **deps:** bump bootsnap from 1.13.0 to 1.14.0 ([604b2b9](https://github.com/nla/nla-arclight/commit/604b2b90e0f93956646d7bd00ba8b338dfc35665))
* **deps:** bump bootsnap from 1.14.0 to 1.15.0 ([5991d59](https://github.com/nla/nla-arclight/commit/5991d599680132ead31afd42efebeae2dc80a03f))
* **deps:** bump brakeman from 5.3.1 to 5.4.0 ([ef85471](https://github.com/nla/nla-arclight/commit/ef85471115da824656c434fe692f739d3fc738eb))
* **deps:** bump catalogue-patrons from `801fdbc` to `b501548` ([231b3ff](https://github.com/nla/nla-arclight/commit/231b3ffc0c530afc04c81ad7b47f0d0eb6c3885d))
* **deps:** bump hiredis-client from 0.12.2 to 0.13.0 ([35d1771](https://github.com/nla/nla-arclight/commit/35d1771d24ffc0bdfbfe867e43511ebef6b4b8c1))
* **deps:** bump hiredis-client from 0.13.0 to 0.14.0 ([6aa20da](https://github.com/nla/nla-arclight/commit/6aa20daf9a6fcc159294a280ad8dff7cb3f26b73))
* **deps:** bump isbang/compose-action from 1.2.0 to 1.3.2 ([87ca123](https://github.com/nla/nla-arclight/commit/87ca123ba105b30e6409f740b3e296de0f48ea3b))
* **deps:** bump isbang/compose-action from 1.3.2 to 1.4.0 ([469c4ec](https://github.com/nla/nla-arclight/commit/469c4ec719a0aa61f4b611ec1704987f7f222a44))
* **deps:** bump isbang/compose-action from 1.4.0 to 1.4.1 ([9f3f2f1](https://github.com/nla/nla-arclight/commit/9f3f2f1ddfae7b5218db915a1f5b969e5038cfb4))
* **deps:** bump jquery-rails from 4.5.0 to 4.5.1 ([744e362](https://github.com/nla/nla-arclight/commit/744e362c27a60ed8b52e1a6bb652df9efb69de8c))
* **deps:** bump loofah from 2.19.0 to 2.19.1 ([711a46c](https://github.com/nla/nla-arclight/commit/711a46c9c197289ddef57f756a0518fd5c925d65))
* **deps:** bump mysql2 from 0.5.4 to 0.5.5 ([4709d07](https://github.com/nla/nla-arclight/commit/4709d076c4c1a13321ba7ca5fbcc76ef9bec6ad1))
* **deps:** bump puma from 5.6.5 to 6.0.0 ([f39b2ec](https://github.com/nla/nla-arclight/commit/f39b2ecdefc87ccf59868e355b2e0991f69097fa))
* **deps:** bump rails-html-sanitizer from 1.4.3 to 1.4.4 ([7da2f50](https://github.com/nla/nla-arclight/commit/7da2f50e6be47fe5a83c80a9b2d6a40465f386ac))
* **deps:** bump redis from 4.8.0 to 5.0.5 ([a737233](https://github.com/nla/nla-arclight/commit/a737233046bbe835276f19485e4034e88a98c5e0))
* **deps:** bump ruby/setup-ruby from 1.117.0 to 1.118.0 ([a773e49](https://github.com/nla/nla-arclight/commit/a773e4977fa3221ae93f18dc6f7993882b2f6c85))
* **deps:** bump ruby/setup-ruby from 1.118.0 to 1.120.0 ([f29215a](https://github.com/nla/nla-arclight/commit/f29215a79ecd2cec6743add28b31744fb406bfb3))
* **deps:** bump ruby/setup-ruby from 1.120.0 to 1.122.0 ([d10cbb3](https://github.com/nla/nla-arclight/commit/d10cbb3ef7ac2a55a8ae3fa4dde507dd63e93967))
* **deps:** bump ruby/setup-ruby from 1.122.0 to 1.126.0 ([92f35de](https://github.com/nla/nla-arclight/commit/92f35de86bf87a2ec8ac6a3f77037a7877df8c27))
* **deps:** bump stimulus-rails from 1.1.0 to 1.1.1 ([04fdf28](https://github.com/nla/nla-arclight/commit/04fdf283f3e561c9d13b556d692d66fd0d67ce84))
* **deps:** bump stimulus-rails from 1.1.1 to 1.2.1 ([24f4559](https://github.com/nla/nla-arclight/commit/24f455982efe7ab011ba58b4816e3ac9fc76b80d))
* **deps:** bump strong_migrations from 1.3.1 to 1.3.2 ([f31a130](https://github.com/nla/nla-arclight/commit/f31a1309d91623ee6cafabc9776c455bda7bb8f8))
* **deps:** bump strong_migrations from 1.3.2 to 1.4.0 ([6978135](https://github.com/nla/nla-arclight/commit/697813563945450842283e7dedd6b1143e1a160a))
* **deps:** bump turbo-rails from 1.3.0 to 1.3.1 ([f3305d1](https://github.com/nla/nla-arclight/commit/f3305d1c09e0d6b186aa7640fd9feb2131570e4e))
* **deps:** bump turbo-rails from 1.3.1 to 1.3.2 ([39660e6](https://github.com/nla/nla-arclight/commit/39660e6656a36c10d0ae8c037f142f35e0caf863))
* **deps:** bump twitter-typeahead-rails ([1b53bab](https://github.com/nla/nla-arclight/commit/1b53bab7f18deca1d3edc3ecc9a09b3bd8edb57a))
* **deps:** update dependencies via "bundle update" ([6d5f839](https://github.com/nla/nla-arclight/commit/6d5f839524b56cc6afcb0e681b7eec791388930b))
* **deps:** use latest blacklight-solrcloud-repository while unreleased ([ef52fce](https://github.com/nla/nla-arclight/commit/ef52fcef0be61c4e9cb7dd12286068512918c618))
* downgrade to Ruby 3.0.4 support development on Big Sur ([9658a11](https://github.com/nla/nla-arclight/commit/9658a11e3404aafdc573f2dae346bfc4c075b3f0))
* exclude solr_wrapper rake task if staging or production ([32a985e](https://github.com/nla/nla-arclight/commit/32a985e168b7add9651291a6a06afb6e8cbbd50c))
* fix deprecations and title config ([503ed05](https://github.com/nla/nla-arclight/commit/503ed055b6521b2986f6c82e910f34f71c982585))
* initial commit ([a9243f7](https://github.com/nla/nla-arclight/commit/a9243f76c85aa7426b916b32129a46dc5a40dc05))
* integrate blacklight-solrcloud-repository gem ([7c753a1](https://github.com/nla/nla-arclight/commit/7c753a1d75f01579f0cabfd450f315654a9148dd))
* modifies Blacklight Solr adapter config ([01541a3](https://github.com/nla/nla-arclight/commit/01541a31cd0acaf383083a88a72fc5a089649975))
* modify routing to match server config ([fdb3c14](https://github.com/nla/nla-arclight/commit/fdb3c147f745382b38cf41b5f72f9eb58922ddc5))
* modify valid hosts in config ([7dac85e](https://github.com/nla/nla-arclight/commit/7dac85e3ac877ad8b2c1b5e72dc66a9e29c0ce00))
* prepare for public beta release ([8211a75](https://github.com/nla/nla-arclight/commit/8211a75239d5ac95f4e66b3526abcdbad967011b))
* regenerate Gemfile.lock ([83284b8](https://github.com/nla/nla-arclight/commit/83284b8fd0b6ff0e09d024790d64c34234519466))
* remove arm64 Darwin platform from Gemfile.lock ([f97767c](https://github.com/nla/nla-arclight/commit/f97767cbd99a2f22e3e98df4b3eef6f922116b2e))
* revert changes to deploy script ([53771a1](https://github.com/nla/nla-arclight/commit/53771a1af394b009005d9970d6bfcf7ab8f2619b))
* scope routes under "/findingaids" path ([66f3992](https://github.com/nla/nla-arclight/commit/66f39924f1ae46f5dcb4de32f6221a92821d9955))
* update database config ([f68be73](https://github.com/nla/nla-arclight/commit/f68be730fa3183bbb0da9d2c1ef35fb52c1467be))
* update database config ([5029876](https://github.com/nla/nla-arclight/commit/502987613f46154bcc8b9dd149ab52f9ebf98802))
* update dependencies ([f09a8d2](https://github.com/nla/nla-arclight/commit/f09a8d25d543e668b8fa2378b8cb4712ab66848e))
* update dependencies ([5dbb79b](https://github.com/nla/nla-arclight/commit/5dbb79b468e77257ede63cf1c8aa7a13c129433f))
* update dependencies ([6dfa197](https://github.com/nla/nla-arclight/commit/6dfa1973c156e0ab9fb3d99d29460a41fc21e87d))
* update dependency on catalogue-patrons ([29a5cf7](https://github.com/nla/nla-arclight/commit/29a5cf741c80d310a3019de6761c5979d4906198))
* update NLA repository thumbnail ([da1b288](https://github.com/nla/nla-arclight/commit/da1b288ddfaff6b32dcdb8fcc2727c32aa46cea9))
* updates dependencies ([5c752d1](https://github.com/nla/nla-arclight/commit/5c752d147fea2a297eafc6fcfa248553472eff65))
* upgrade Ruby to 3.1.3 ([8969e46](https://github.com/nla/nla-arclight/commit/8969e4680e611aa8258ad29ded105395cbec0022))
* upgrade to Ruby 3.2.0 ([1420d45](https://github.com/nla/nla-arclight/commit/1420d45da9d9a880372a7b42acdb31fe3eb8a43e))
* upgraded CatalogController from ArcLight ([c3c0b90](https://github.com/nla/nla-arclight/commit/c3c0b9039120aac9bad4dbfe75470e06d53c0647))