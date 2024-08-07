# Changelog

## [3.3.0](https://github.com/nla/nla-arclight/compare/nla-arclight-3.2.0...nla-arclight/3.3.0) (2024-06-28)


### Features

* cache related docs request response ([79fde27](https://github.com/nla/nla-arclight/commit/79fde270a89922ff5a617ed9885d5d8d96686577))
* compare note headings using parameterized values ([e3df011](https://github.com/nla/nla-arclight/commit/e3df0117f40e2f381920d43a08f19d5db8970834))
* extract EAD notes by header ([5fffcc5](https://github.com/nla/nla-arclight/commit/5fffcc5fe3876fc3aa24781c4ef2aa8cbf08241e))
* extract notes by header ([81e0a52](https://github.com/nla/nla-arclight/commit/81e0a52278e0e43361d9e57198d7aea315a97680))
* implement rendering of related document list ([32e7a24](https://github.com/nla/nla-arclight/commit/32e7a24d18f8e0c79ea1dbe5f73421ad91ef9188))
* implement service call ([3a90f00](https://github.com/nla/nla-arclight/commit/3a90f00bf123269510566b6dc917e99dab2938f5))
* modify related docs download URL ([76830e3](https://github.com/nla/nla-arclight/commit/76830e3a945ef6db040fa03fce294f3e0b81c4e0))
* refine display and formatting of notes ([07cac10](https://github.com/nla/nla-arclight/commit/07cac10cb2a033afe35ad0d8cd29c0d16735495f))
* render chronlist, bibref and tables in notes ([3ed183a](https://github.com/nla/nla-arclight/commit/3ed183a756dbb0abc9dccac666971d541f79ba2f))


### Bug Fixes

* accommodate chronlists that are not duplicates ([2665df2](https://github.com/nla/nla-arclight/commit/2665df2adba16516d02a48aa6f7c5eb89994a1c0))
* change chronlist table header level to h4 ([effca62](https://github.com/nla/nla-arclight/commit/effca62ea133cd7b6654084d5db8c3436b859182))
* don't attempt to wrap non-Strings in an HTML paragraph ([981c59c](https://github.com/nla/nla-arclight/commit/981c59ce44913520e0a2a6f47e84f0f43cf8cec6))
* handle case where bibref is a Hash ([1633c47](https://github.com/nla/nla-arclight/commit/1633c475dd0e60e6fa3d1abc708c16055f1095db))
* ignore chronlists that are in an array ([503aac1](https://github.com/nla/nla-arclight/commit/503aac1bce2527eefe42d72e478f51c1b8286715))
* normalize note paragraphs and HTML wrapping ([1c5bdd1](https://github.com/nla/nla-arclight/commit/1c5bdd1d4ae8a288e7a2e68a5d110996ef6cf325))
* prevent subnotes from crashing application ([3e8b7b9](https://github.com/nla/nla-arclight/commit/3e8b7b93b690438830c17b325335db2b1e113595))
* render HTML markup in note paragraphs ([d0fe402](https://github.com/nla/nla-arclight/commit/d0fe402171ab1c1a570937cc659bc33c7e0a42ec))
* return nil extent information to avoid displaying an empty heading ([8abbbaf](https://github.com/nla/nla-arclight/commit/8abbbafd9244e7ae8a2b306c0866ab6e30e4516f))
* translate Scope and Contents heading ([04cf925](https://github.com/nla/nla-arclight/commit/04cf925b87c82d8257ce134372e3625d2fdcd448))


### Code Refactoring

* restyle related documents link ([d954e41](https://github.com/nla/nla-arclight/commit/d954e41eec0282f35b52fcc2cd19caf0fbe6d8fd))


### Tests

* add tests for related documents ([929e1b8](https://github.com/nla/nla-arclight/commit/929e1b80c17a82de147616649fb569f83622467d))
* fix specs ([7241f9c](https://github.com/nla/nla-arclight/commit/7241f9cae7fb166084bbf75151dde836a91d61ae))


### Build System

* add rubocop-factory_bot ([cdcc002](https://github.com/nla/nla-arclight/commit/cdcc00244f05c80151263677fc1bcc9f66fd3123))
* **deps-dev:** bump binding_of_caller from 1.0.0 to 1.0.1 ([5e31a81](https://github.com/nla/nla-arclight/commit/5e31a81a638533d5e054d68ed4a3d9d3b8f837b8))
* **deps-dev:** bump rack-mini-profiler from 3.1.1 to 3.3.1 ([3734cb5](https://github.com/nla/nla-arclight/commit/3734cb546ee224751b788179e1fe6e1e747fe434))
* **deps-dev:** bump rspec-rails from 6.1.1 to 6.1.2 ([b36fa17](https://github.com/nla/nla-arclight/commit/b36fa17779c3b342ccde0aa4a33f766970e010b2))
* **deps-dev:** bump rspec-rails from 6.1.2 to 6.1.3 ([5a9d743](https://github.com/nla/nla-arclight/commit/5a9d7431e178338bee9cf442d17cd562e724f898))
* **deps-dev:** bump rubocop-performance from 1.21.0 to 1.21.1 ([5dfc787](https://github.com/nla/nla-arclight/commit/5dfc78706582aec4851236fd49444208a3df0844))
* **deps-dev:** bump rubocop-rspec from 2.25.0 to 3.0.1 ([716dcdb](https://github.com/nla/nla-arclight/commit/716dcdb6c443eaa5f88eab19214f92da9ff66380))
* **deps-dev:** bump selenium-webdriver from 4.21.1 to 4.22.0 ([ce5830f](https://github.com/nla/nla-arclight/commit/ce5830f7056997f109a29ee2609040c3d45665a7))
* **deps-dev:** bump stackprof from 0.2.25 to 0.2.26 ([a827f87](https://github.com/nla/nla-arclight/commit/a827f87cda9fee4fdc0ee6ae389e9fe901434a06))
* **deps-dev:** bump standard from 1.32.0 to 1.37.0 ([8425d07](https://github.com/nla/nla-arclight/commit/8425d077b8af88c5fd9632be61816076a843462e))
* **deps-dev:** bump standard from 1.37.0 to 1.39.0 ([e4e24c6](https://github.com/nla/nla-arclight/commit/e4e24c6f369f826e0cf32416e03a49529700dded))
* **deps:** bump actionpack from 7.0.8.3 to 7.0.8.4 ([f8635bd](https://github.com/nla/nla-arclight/commit/f8635bdd914b3f0e0660843d5f39f81684ae6553))
* **deps:** bump arclight from 1.1.0 to 1.4.0 ([6477805](https://github.com/nla/nla-arclight/commit/647780514bb206beb89f2d61a6b961df359cfc79))
* **deps:** bump blacklight-frontend from 8.0.1 to 8.3.0 ([966683f](https://github.com/nla/nla-arclight/commit/966683f55d336ad3b74847a3cf90d4db5f6a70b0))
* **deps:** bump braces from 3.0.2 to 3.0.3 ([7321b67](https://github.com/nla/nla-arclight/commit/7321b67b4e04bd5c675df6f5584831ddcd1379e2))
* **deps:** bump esbuild from 0.21.4 to 0.21.5 ([17c49e8](https://github.com/nla/nla-arclight/commit/17c49e8d8a949e683744e6038c0749eca96d9bc8))
* **deps:** bump hiredis-client from 0.18.0 to 0.22.2 ([7dcaf25](https://github.com/nla/nla-arclight/commit/7dcaf25a6797494c91251ff9bd79d4e6fe81cdd2))
* **deps:** bump nodemon from 3.1.2 to 3.1.3 ([6c62761](https://github.com/nla/nla-arclight/commit/6c627619d12ee1c1c19381c1fff4ed596fee9f09))
* **deps:** bump nodemon from 3.1.3 to 3.1.4 ([6cd02d3](https://github.com/nla/nla-arclight/commit/6cd02d32aa250620650bace8a67ac40cb8134556))
* **deps:** bump nokogiri from 1.16.5 to 1.16.6 ([721b156](https://github.com/nla/nla-arclight/commit/721b1567a3c99299f98001dbaaed1e45d42d5e9c))
* **deps:** bump sass from 1.71.1 to 1.77.5 ([cb19eb2](https://github.com/nla/nla-arclight/commit/cb19eb237538e72e9c6de0f293d498f19a6ec4ae))
* **deps:** bump sass from 1.77.5 to 1.77.6 ([6606535](https://github.com/nla/nla-arclight/commit/6606535c092a78e562ddfcfb003dee3ebcee11ad))
* **deps:** bump sprockets-rails from 3.4.2 to 3.5.1 ([bcad2af](https://github.com/nla/nla-arclight/commit/bcad2af77e996cc672f80dadd3f060b5df181168))
* **deps:** bump yabeda-prometheus from 0.9.0 to 0.9.1 ([bd96f9e](https://github.com/nla/nla-arclight/commit/bd96f9e8be852cb7e05ffaafa1a4b5f1b6d7ea42))
* fix rubocop dependencies ([fe11410](https://github.com/nla/nla-arclight/commit/fe114106985b37514952c2de0c9e86f3322ccd59))


### Continuous Integration

* cleanup release workflows and config ([356482d](https://github.com/nla/nla-arclight/commit/356482dfa9908c7defc2c1965257d9c91cb9f822))
* upgrade release-please action ([5a9e9a9](https://github.com/nla/nla-arclight/commit/5a9e9a96f44333675097653f346be6aa380faa59))

## [3.2.0](https://github.com/nla/nla-arclight/compare/3.1.0...3.2.0) (2024-06-04)


### Miscellaneous

* prepare release ([410edb8](https://github.com/nla/nla-arclight/commit/410edb88e33186b3ac2271c015a291a338714c70))
* release 3.2.0 ([abb18fa](https://github.com/nla/nla-arclight/commit/abb18fac896adc0b9edba3f77a75079ad0a5c77a))
* update nla-blacklight_common dependency ([bf76ce7](https://github.com/nla/nla-arclight/commit/bf76ce79b206cf042ca4b3ca7f9f3c54bfe5b644))


### Build System

* **deps-dev:** bump debug from 1.8.0 to 1.9.2 ([6829718](https://github.com/nla/nla-arclight/commit/68297180b293e213ad6af6eb974a6d6f97bfeaf8))
* **deps-dev:** bump rdoc from 6.6.0 to 6.7.0 ([f127b32](https://github.com/nla/nla-arclight/commit/f127b3221a8fc46804bbee3afb0b53fd47215eed))
* **deps-dev:** bump rubocop-performance from 1.19.1 to 1.21.0 ([eaee48d](https://github.com/nla/nla-arclight/commit/eaee48d96b0ca460ec8625d8b0376f29bcebe502))
* **deps-dev:** bump selenium-webdriver from 4.17.0 to 4.21.1 ([3c98b38](https://github.com/nla/nla-arclight/commit/3c98b386cdfb132e230a14bb844757826335db43))
* **deps:** bump @hotwired/turbo-rails from 7.3.0 to 8.0.4 ([f0a15bf](https://github.com/nla/nla-arclight/commit/f0a15bf70b7f0ffa9f3f1870b942e8cad744a2bf))
* **deps:** bump autoprefixer from 10.4.17 to 10.4.19 ([5745133](https://github.com/nla/nla-arclight/commit/574513320027f4d02a053f4972718f30d4158ee8))
* **deps:** bump esbuild from 0.20.0 to 0.21.4 ([284bf59](https://github.com/nla/nla-arclight/commit/284bf5925b877e4d50369ed1f839890e6fc66972))
* **deps:** bump mysql2 from 0.5.5 to 0.5.6 ([6337a3f](https://github.com/nla/nla-arclight/commit/6337a3fcb678c86d8a236ab4a11b091b80e4754b))
* **deps:** bump nodemon from 3.0.3 to 3.1.2 ([b1692b5](https://github.com/nla/nla-arclight/commit/b1692b5923269ed2a6447f357c9c074c4cdf4dfc))
* **deps:** bump postcss from 8.4.33 to 8.4.38 ([a30870b](https://github.com/nla/nla-arclight/commit/a30870bb7bcee6f881dca178016017d74c35ab35))
* **deps:** bump redis from 5.0.8 to 5.1.0 ([a4cfbd2](https://github.com/nla/nla-arclight/commit/a4cfbd206598816138c52b07ebf3e6417f1e1ac1))
* **deps:** bump rexml from 3.2.6 to 3.2.8 ([2fe29fa](https://github.com/nla/nla-arclight/commit/2fe29fa7a52e520cd47af86eb27a1533c1b051c1))

## [3.1.0](https://github.com/nla/nla-arclight/compare/3.0.0...3.1.0) (2024-05-14)


### Features

* disable login during FOLIO updates ([756f401](https://github.com/nla/nla-arclight/commit/756f401b1f836d6eccf69e9e380589ca4b208081))
* implement email 2fa alert ([1ada44d](https://github.com/nla/nla-arclight/commit/1ada44dbc8d9be9d17c4659700f79c11b0c3b8e0))


### Bug Fixes

* add finding aid level and unit id ([f3882e0](https://github.com/nla/nla-arclight/commit/f3882e0a068d436efa97a441454dab65c5628380))
* fix indentation ([4edf79d](https://github.com/nla/nla-arclight/commit/4edf79de6254a006357fe3904a7cdc2ca3afe25e))


### Miscellaneous

* prepare release ([dbeacfe](https://github.com/nla/nla-arclight/commit/dbeacfee33753286031e020c0fd7e91a5d7ba123))
* update nla-blacklight_common dependency ([4875942](https://github.com/nla/nla-arclight/commit/4875942c532e15c313a3f1a81df185c53a6bafac))
* update nla-blacklight_common dependency ([1ae670c](https://github.com/nla/nla-arclight/commit/1ae670c3cdc380eb728172eb66a9054b253b1646))
* update nla-blacklight_common dependency ([242d7df](https://github.com/nla/nla-arclight/commit/242d7dffa041d540903892e7a86ae8c8df02211f))
* update nla-blacklight_common in Gemfile.lock ([b94e4fc](https://github.com/nla/nla-arclight/commit/b94e4fc090f3050b7af2af55594233f31a2a20ff))


### Tests

* fix specs for BreadcrumbsHierarchyComponent ([3bb54aa](https://github.com/nla/nla-arclight/commit/3bb54aa1c578460b5228d24c3eb542220d3fd7bc))
* tighten up expectations ([28e210f](https://github.com/nla/nla-arclight/commit/28e210fad7134263fff54c79aeab2f623b175a4a))


### Build System

* update nla-blacklight_common ([d345a5f](https://github.com/nla/nla-arclight/commit/d345a5f11d1a2fb1354224bbf66aa02cb6574fd7))

## [3.0.0](https://github.com/nla/nla-arclight/compare/2.7.1...3.0.0) (2024-03-13)


### ⚠ BREAKING CHANGES

* upgrade to Arclight 1 (Blacklight 8)

### Features

* upgrade to Arclight 1 (Blacklight 8) ([c7360c8](https://github.com/nla/nla-arclight/commit/c7360c875ea716bb8f3d55e359b140d8b1404f17))


### Bug Fixes

* configure correct Solr search adapter in blacklight.yml ([8781c33](https://github.com/nla/nla-arclight/commit/8781c338878fe20280004ce59d7b262c3f4bbc30))
* downgrade postcss-cli for nodejs version compatiblity ([08a1efe](https://github.com/nla/nla-arclight/commit/08a1efe2f76e51be27ed658812cb81ef8ef45c67))
* fix styling of blacklight range limit ([f6558d6](https://github.com/nla/nla-arclight/commit/f6558d6a08b4f8a44f3899569e9c367a73d6ebe9))
* remove repository facet from arclight ([4a1b7db](https://github.com/nla/nla-arclight/commit/4a1b7dbf09bb5abee929c7a49a4f9d602e4fee81))
* remove repository facet from arclight ([df8f44c](https://github.com/nla/nla-arclight/commit/df8f44caae56dfd07672123789a31fd7a771926a))
* resolve code review comments ([1eeb5da](https://github.com/nla/nla-arclight/commit/1eeb5da3177a2e674c6a31d37629aaf38547a40e))
* style blacklight range limit modal graph ([fee61c3](https://github.com/nla/nla-arclight/commit/fee61c3c3a7b2126ef036ec2612af54151d9970c))
* update vulnerable dependencies ([87912aa](https://github.com/nla/nla-arclight/commit/87912aa1912b4e7efb64bc52cc3e37ad729a4759))
* upgrade Rails to address CVE-2024-26143 ([d5a13e2](https://github.com/nla/nla-arclight/commit/d5a13e23ce56d443ad053489b5634c46b1254f8d))


### Reverts

* "build(deps): bump postcss-cli from 10.1.0 to 11.0.0" ([047d214](https://github.com/nla/nla-arclight/commit/047d2141fefca1d5617308d6257fbb4cb6dc219c))


### Miscellaneous

* prepare 3.0.0 release ([1cafd6c](https://github.com/nla/nla-arclight/commit/1cafd6c0f0c22586ae40be39c23829ed3e414504))
* replace dotenv-rails with dotenv ([9e732da](https://github.com/nla/nla-arclight/commit/9e732dabb0abff085a2614ade37cb2ee2b412347))
* resolve merge conflicts ([67a212c](https://github.com/nla/nla-arclight/commit/67a212cda7153e3124df77d9487c7298a56ca0fa))
* resolve merge conflicts ([ba0ee7a](https://github.com/nla/nla-arclight/commit/ba0ee7aadcf1e935f1994d2f06501189586a8de2))
* update nla-blacklight_common ([963cc9f](https://github.com/nla/nla-arclight/commit/963cc9f708e65e7db9fcba1eb1790e2dd98c87c6))
* update nla-blacklight_common dependency ([8998cdc](https://github.com/nla/nla-arclight/commit/8998cdc409f24b5a3138e11ac8f5ca0a3b2c4e57))
* update README ([50a25f3](https://github.com/nla/nla-arclight/commit/50a25f39ef53e646191968fa1492e90a2ba5bb88))
* upgrade nodejs dependencies ([02eb671](https://github.com/nla/nla-arclight/commit/02eb671866e44486ce6401ee557e1dd618773f2b))


### Build System

* **deps-dev:** bump factory_bot_rails from 6.2.0 to 6.4.3 ([d8e3867](https://github.com/nla/nla-arclight/commit/d8e3867d23e29eb8212c76a9e1106c6d91e1927c))
* **deps-dev:** bump rspec-rails from 6.1.0 to 6.1.1 ([7759990](https://github.com/nla/nla-arclight/commit/77599901acc3bbebcea51aad4a5bab6370754859))
* **deps-dev:** bump rubocop-rails from 2.22.1 to 2.23.1 ([103e535](https://github.com/nla/nla-arclight/commit/103e535a8d6bcfc980bdc4826072a007c6209174))
* **deps-dev:** bump selenium-webdriver from 4.15.0 to 4.17.0 ([f35a692](https://github.com/nla/nla-arclight/commit/f35a69271202ec2d5c881225b20794f1a4b1cca2))
* **deps-dev:** bump shoulda-matchers from 5.3.0 to 6.1.0 ([d0b4bc5](https://github.com/nla/nla-arclight/commit/d0b4bc5459887fd68a2a90afb16e3de9b8d707c1))
* **deps:** bump blacklight-locale_picker from 1.0.0 to 1.1.0 ([1b9fdbd](https://github.com/nla/nla-arclight/commit/1b9fdbdc998ac6ecd9f81badd82941d262f5cfcf))
* **deps:** bump bootstrap from 5.3.1 to 5.3.2 ([14331f1](https://github.com/nla/nla-arclight/commit/14331f1570555fb20facede3ede90a1732ad023c))
* **deps:** bump cssbundling-rails from 1.3.3 to 1.4.0 ([86f958c](https://github.com/nla/nla-arclight/commit/86f958c299b7ba74c5d0e3184610771871a6b5b8))
* **deps:** bump esbuild from 0.19.2 to 0.20.0 ([49898e3](https://github.com/nla/nla-arclight/commit/49898e39674231630b7277e22be2614acad95290))
* **deps:** bump jsbundling-rails from 1.2.1 to 1.3.0 ([1b93695](https://github.com/nla/nla-arclight/commit/1b93695ee3c259d5475103dce27ab2fb2dcb1dd0))
* **deps:** bump nodemon from 3.0.1 to 3.0.3 ([6fc01f0](https://github.com/nla/nla-arclight/commit/6fc01f017f269814766c07b8f1313b34dae93a0f))
* **deps:** bump postcss from 8.4.28 to 8.4.31 ([bfd12f9](https://github.com/nla/nla-arclight/commit/bfd12f94e1f92a1688f1e8d6874a3ac673d0408a))
* **deps:** bump postcss from 8.4.28 to 8.4.33 ([92f1e2a](https://github.com/nla/nla-arclight/commit/92f1e2a5ec837db5c82a3c6076995095258fad32))
* **deps:** bump postcss-cli from 10.1.0 to 11.0.0 ([435d081](https://github.com/nla/nla-arclight/commit/435d081acdfa85638280cc390b5b121bc0578ab9))
* **deps:** bump stimulus-rails from 1.3.0 to 1.3.3 ([abce2f5](https://github.com/nla/nla-arclight/commit/abce2f5e6d20ea15a6fe8af70fdce5ce511c9ce3))
* **deps:** bump strong_migrations from 1.6.4 to 1.7.0 ([ccfed20](https://github.com/nla/nla-arclight/commit/ccfed20a590940193903f9326b14ef7a14a5cf4c))
* ignore CVE-2023-51774 until after release ([d430d70](https://github.com/nla/nla-arclight/commit/d430d70aed46e50b594ab38d0322a9acb12affee))
* point nla-blacklight_common dependency to main branch ([38a8122](https://github.com/nla/nla-arclight/commit/38a812224d3ee831db21c8b2f1912ee23489ef70))

## [2.7.1](https://github.com/nla/nla-arclight/compare/2.7.0...2.7.1) (2023-11-29)


### Miscellaneous

* prepare release ([e29170a](https://github.com/nla/nla-arclight/commit/e29170ab69b2f7f6dd66a43af555ebf0ccf34929))


### Build System

* **deps-dev:** bump faker from 3.2.1 to 3.2.2 ([0419051](https://github.com/nla/nla-arclight/commit/0419051f174c9e19eeed94851e510a60eb4f150a))
* **deps-dev:** bump selenium-webdriver from 4.14.0 to 4.15.0 ([4722bc0](https://github.com/nla/nla-arclight/commit/4722bc092d2ad0070d568b64149f4755ecda4de9))
* **deps-dev:** bump standard from 1.31.2 to 1.32.0 ([b8743db](https://github.com/nla/nla-arclight/commit/b8743db2df7f7f9835e56500581067a390d57d60))
* **deps:** bump blacklight_range_limit from 8.3.0 to 8.4.0 ([1903667](https://github.com/nla/nla-arclight/commit/1903667381197c2901d43405973841c04e6ca6f5))
* **deps:** bump bootsnap from 1.16.0 to 1.17.0 ([8459dc0](https://github.com/nla/nla-arclight/commit/8459dc08a609b78943be52e626a460ee6cb49640))

## [2.7.0](https://github.com/nla/nla-arclight/compare/2.6.0...2.7.0) (2023-11-17)


### Features

* Update Join us link in primary nav ([4562c1b](https://github.com/nla/nla-arclight/commit/4562c1b70ec81536eff7f449a5cffeab3a16a463))


### Bug Fixes

* change request login alert wording ([ea93845](https://github.com/nla/nla-arclight/commit/ea938452473e78f60f8b82641a227f0aa5674d2b))
* set headers to not cache any pages ([e02aa46](https://github.com/nla/nla-arclight/commit/e02aa4680f83c3508570b404931badce4e80f925))


### Miscellaneous

* prepare for release ([3f5dc01](https://github.com/nla/nla-arclight/commit/3f5dc01c12a696ec66f8d42084c0097afaf1c96d))
* pull in backchannel logout changes ([3549416](https://github.com/nla/nla-arclight/commit/3549416daa15013746b452a5f462466ed49f4d73))
* pull in changes from nla-blacklight_common ([ff31bb2](https://github.com/nla/nla-arclight/commit/ff31bb25f7bd62a88ecd4a0c7f3dd90e2aabd873))
* pull in changes in common code ([3f0eb77](https://github.com/nla/nla-arclight/commit/3f0eb7723809d88413e00da5690ce4f09be92871))
* pull in fixes to session_token ([a61989c](https://github.com/nla/nla-arclight/commit/a61989c40b16c494541e06f5c8220620f44f61d2))
* remove keycloak patron login flag ([ca645bf](https://github.com/nla/nla-arclight/commit/ca645bfe3862590d2a01500fb08288673ece4f94))


### Build System

* **deps-dev:** bump rubocop-rails from 2.21.2 to 2.22.1 ([f50b186](https://github.com/nla/nla-arclight/commit/f50b1868f8c29f10be23aa7c3cd5646e406d87a1))
* **deps-dev:** bump rubocop-rspec from 2.24.1 to 2.25.0 ([c258899](https://github.com/nla/nla-arclight/commit/c25889912621a90710c6a4339983b7b2151fc55c))
* **deps:** bump hiredis-client from 0.17.1 to 0.18.0 ([e7539dc](https://github.com/nla/nla-arclight/commit/e7539dcb7ebfffba9ff0bcf592494468bdfb4b44))
* **deps:** bump importmap-rails from 1.2.1 to 1.2.3 ([972d9a4](https://github.com/nla/nla-arclight/commit/972d9a46dc24c43894aad212c3459a08c038bf11))
* **deps:** bump redis from 5.0.7 to 5.0.8 ([734389c](https://github.com/nla/nla-arclight/commit/734389ca61861441451893508b7b722646c2d721))

## [2.6.0](https://github.com/nla/nla-arclight/compare/2.5.0...2.6.0) (2023-11-03)


### Features

* update screen reader text for twitter icon ([694305c](https://github.com/nla/nla-arclight/commit/694305c4880eb255b758eac72b4b32cc6ba717fd))
* Update twitter icon to X ([8317f68](https://github.com/nla/nla-arclight/commit/8317f68a1d0ff39c826b3244af09e0e5b4390852))


### Bug Fixes

* pin blacklight version to avoid view component upgrade ([545ed88](https://github.com/nla/nla-arclight/commit/545ed88bf475543f710ae54d4f7f26a66ac4f11f))


### Miscellaneous

* prepare for release ([626ec7b](https://github.com/nla/nla-arclight/commit/626ec7b1804110030c32b6bcf19aca581a552e21))
* pull in changes to login page text ([4672d3b](https://github.com/nla/nla-arclight/commit/4672d3bcd64abbada35a5be6f47950bc9b0e2caf))


### Code Refactoring

* pull in changes to staff login button style ([96ad55d](https://github.com/nla/nla-arclight/commit/96ad55d4c0a1012dd8cc6693b875ae47dce6e336))


### Build System

* **deps:** bump hiredis-client from 0.17.0 to 0.17.1 ([9466568](https://github.com/nla/nla-arclight/commit/9466568c472c55af8f4cd2d647450166dcb6a106))
* **deps:** bump strong_migrations from 1.6.3 to 1.6.4 ([fec4e67](https://github.com/nla/nla-arclight/commit/fec4e67655f6c3d89253576beb8b441de335252a))

## [2.5.0](https://github.com/nla/nla-arclight/compare/2.4.3...2.5.0) (2023-10-20)


### Features

* pull in changes for login page ([0f09b8d](https://github.com/nla/nla-arclight/commit/0f09b8d801140fa218a1ba794ec2b810150a2cb5))


### Miscellaneous

* prepare for release ([dbb99c1](https://github.com/nla/nla-arclight/commit/dbb99c14c6636c4d2e351477c449d5a499248334))
* pull in patron Keycloak changes ([32e564a](https://github.com/nla/nla-arclight/commit/32e564aad718ab9e9d128b34ad9fbadb7a62b51a))
* upgrade dependencies ([e8fd718](https://github.com/nla/nla-arclight/commit/e8fd718321846d35367c7b5f5e121807044917b6))

## [2.4.3](https://github.com/nla/nla-arclight/compare/2.4.2...2.4.3) (2023-09-27)


### Build System

* **deps-dev:** bump rubocop-rspec from 2.24.0 to 2.24.1 ([d3d98db](https://github.com/nla/nla-arclight/commit/d3d98db2c777741e916f01f1ee4073d74c7891c1))
* **deps:** bump puma from 6.3.1 to 6.4.0 ([041a813](https://github.com/nla/nla-arclight/commit/041a813b9e5b2bd6f18208dab71656479560c223))
* **deps:** bump strong_migrations from 1.6.2 to 1.6.3 ([fc0c821](https://github.com/nla/nla-arclight/commit/fc0c8213e1dd876a6cc7b17d5bedd5bfaa87513e))

## [2.4.2](https://github.com/nla/nla-arclight/compare/2.4.1...2.4.2) (2023-09-22)


### Miscellaneous

* prepare release ([28bf158](https://github.com/nla/nla-arclight/commit/28bf158c1def3e5f60c0523225c589dcb197ae0e))


### Tests

* change rspec format to Fuubar ([e779341](https://github.com/nla/nla-arclight/commit/e7793415e360bac07df862508e6afb1d9a14920d))


### Build System

* **deps-dev:** bump rubocop-rails from 2.20.2 to 2.21.0 ([13352a1](https://github.com/nla/nla-arclight/commit/13352a1c75e7768b9b34c884ba58b6c255d136c6))
* **deps-dev:** bump rubocop-rails from 2.21.0 to 2.21.1 ([51deb4c](https://github.com/nla/nla-arclight/commit/51deb4c6ec86dd7c402bf5c2dbadede22c8a65e9))
* **deps-dev:** bump rubocop-rspec from 2.23.2 to 2.24.0 ([9d46963](https://github.com/nla/nla-arclight/commit/9d46963e87c3101c882b5b2ba001a7e2332625cf))
* **deps-dev:** bump standard from 1.31.0 to 1.31.1 ([1838be5](https://github.com/nla/nla-arclight/commit/1838be53e631ee36ef5193172115fac7b852fabf))
* **deps:** bump actions/checkout from 3 to 4 ([243edda](https://github.com/nla/nla-arclight/commit/243edda87d2b40594b0e2a82f707e0aac0e9b922))
* **deps:** bump hiredis-client from 0.16.0 to 0.17.0 ([8b3a4ac](https://github.com/nla/nla-arclight/commit/8b3a4accad3a540f6b2816e41e5ecb612bffdbe9))
* **deps:** bump rails from 7.0.7.2 to 7.0.8 ([2029b29](https://github.com/nla/nla-arclight/commit/2029b2984324a189f77614d711ff2db5b762981c))
* **deps:** bump strong_migrations from 1.6.1 to 1.6.2 ([5fa287b](https://github.com/nla/nla-arclight/commit/5fa287bcc1f7c076b91c257de6df849020bce371))

## [2.4.1](https://github.com/nla/nla-arclight/compare/2.4.0...2.4.1) (2023-09-08)


### Bug Fixes

* define further gray colours ([df3c378](https://github.com/nla/nla-arclight/commit/df3c3781863fa4cd2e5a24b385bfbe92198522b4))


### Miscellaneous

* change session cookie security ([b12969b](https://github.com/nla/nla-arclight/commit/b12969bb405b6b1bcbfde71c3c7b738e027b8927))
* prepare next version ([4e77a8b](https://github.com/nla/nla-arclight/commit/4e77a8b2b5cb1cfd804952a3ca5153ba6d78c4e8))
* prepare release ([7b95bf5](https://github.com/nla/nla-arclight/commit/7b95bf5da7af434f6189b6646715a796446019a3))


### Build System

* **deps-dev:** bump webmock from 3.18.1 to 3.19.0 ([a8a0d82](https://github.com/nla/nla-arclight/commit/a8a0d82788d4f102954c905ba2963d39026b9e1e))
* **deps:** bump hiredis-client from 0.15.0 to 0.16.0 ([23d391a](https://github.com/nla/nla-arclight/commit/23d391a1db10af5cbf517c29fec4cf538c009e0f))

## [2.4.0](https://github.com/nla/nla-arclight/compare/2.3.0...2.4.0) (2023-08-25)


### Features

* display search results as 2 columns on tablet ([553c9b0](https://github.com/nla/nla-arclight/commit/553c9b0dbf87b62eea43b57943c0178a8b699a70))
* remove http-requests from metrics ([2cbecb5](https://github.com/nla/nla-arclight/commit/2cbecb517d32f315083a632580c6bf3e70fd8dba))


### Bug Fixes

* integrate auth changes in nla-blacklight_common ([9c30ebd](https://github.com/nla/nla-arclight/commit/9c30ebd20c0dac08b548a38929510e17d84a68f8))
* reduce memory allocation and clean up dependencies ([cf78f42](https://github.com/nla/nla-arclight/commit/cf78f42f0016351860bc1643853bdc1addac750a))
* remove scheduler config and update bin/setup ([83071a7](https://github.com/nla/nla-arclight/commit/83071a7f7ddd9c4c8d7f0492118bbbf484ce49b1))
* update blacklight config ([cbc180d](https://github.com/nla/nla-arclight/commit/cbc180d6ec6a98573377bdc6fdfd2bc924d29d67))


### Miscellaneous

* configure Redis cache connection pool ([1bfb75c](https://github.com/nla/nla-arclight/commit/1bfb75c4517a2556ca96f32dd0a4791abfa6be91))
* merge changes from main branch ([608be6c](https://github.com/nla/nla-arclight/commit/608be6ca1ee5672789b1686d45601ac630c95719))
* prepare release ([fde37fd](https://github.com/nla/nla-arclight/commit/fde37fd777ba4091a60519e0e6ffb33eefff3336))
* upgrade dependencies ([e012884](https://github.com/nla/nla-arclight/commit/e01288413e1a0b9e69bc2657e0011f2721131102))

## [2.3.0](https://github.com/nla/nla-arclight/compare/2.2.2...2.3.0) (2023-08-10)


### Features

* export stats for prometheus ([e4b0c22](https://github.com/nla/nla-arclight/commit/e4b0c22b47881a4fcc5aa6bd172f5e6e0a1c342d))


### Bug Fixes

* apply the same styles as in blacklight ([21b3f7b](https://github.com/nla/nla-arclight/commit/21b3f7babd82c2258af3134f1754ce13866f6ea4))
* change green text in modal to grey ([229438a](https://github.com/nla/nla-arclight/commit/229438aa1ffd8fce133b3c4df01a9fb3a51be291))
* display range limit chart on apply ([1592152](https://github.com/nla/nla-arclight/commit/159215248daac9dda4064b609ffb004dc5faf3e8))


### Miscellaneous

* prepare release ([d9a2121](https://github.com/nla/nla-arclight/commit/d9a21210f536b9f78e9c2348979715a1a183dc53))
* upgrade dependencies ([145e317](https://github.com/nla/nla-arclight/commit/145e317e67ff451ba6b287cdd7887bffd4b9d3ae))


### Code Refactoring

* refactor the heading style for all results ([2503005](https://github.com/nla/nla-arclight/commit/2503005dbedd76d933745d4d71e4514398236445))


### Build System

* **deps:** bump hiredis-client from 0.14.1 to 0.15.0 ([0c9b627](https://github.com/nla/nla-arclight/commit/0c9b62716fd10b14c9880d7d7ea05bd663cb686a))

## [2.2.2](https://github.com/nla/nla-arclight/compare/2.2.1...2.2.2) (2023-08-08)


### Miscellaneous

* prepare hotfix ([cb73af3](https://github.com/nla/nla-arclight/commit/cb73af3abfda62591576f3217ed414ebe2fd6cae))

## [2.2.1](https://github.com/nla/nla-arclight/compare/2.2.0...2.2.1) (2023-07-27)


### Bug Fixes

* Clear bookmarks button styling ([fdbd018](https://github.com/nla/nla-arclight/commit/fdbd01888d6d81156022ac55df8711fe6ff3be19))
* clear search session when coming from a bento search ([972da94](https://github.com/nla/nla-arclight/commit/972da947623719432a8223d356ab034666c69981))
* colour contrast for box info and icons ([bb0ce88](https://github.com/nla/nla-arclight/commit/bb0ce88c191a7fdf995be2603c7425c0d8fbee18))
* hide primary nav on tablet & mobile ([c16c3dd](https://github.com/nla/nla-arclight/commit/c16c3dd2a15d97d659de2876973782af529afd27))
* link colours ([7fd6088](https://github.com/nla/nla-arclight/commit/7fd608801774b8f4cffbef7bf1938f26585702ce))
* style bookmarks to match Blacklight ([73fcd4e](https://github.com/nla/nla-arclight/commit/73fcd4e163faf26ff0d339c10cf5cc5093891abd))
* Update URL for help ([dbe913f](https://github.com/nla/nla-arclight/commit/dbe913f7eaa5cee21ffc7694d296e6b9eefa37f3))


### Miscellaneous

* prepare for Sprint 5 ([e282fea](https://github.com/nla/nla-arclight/commit/e282fea5a47426402f8f05222449bdbecf27876c))
* prepare Sprint 5 release ([db77dca](https://github.com/nla/nla-arclight/commit/db77dca01f6a72e02601d2a89a94680024418ba0))
* resolve merge collisions ([dde5a6a](https://github.com/nla/nla-arclight/commit/dde5a6ac8602ceb004a66b7f7e87c26ae8c6e5a5))
* update dependencies ([ab0eb2e](https://github.com/nla/nla-arclight/commit/ab0eb2e4e3992eda710059276f45be8b0a04b63e))

## [2.2.0](https://github.com/nla/nla-arclight/compare/2.1.0...2.2.0) (2023-07-12)


### Features

* add active link to navbar ([f9289ec](https://github.com/nla/nla-arclight/commit/f9289ecb9a9c77338c688823773fe7d710b1b849))
* display link to catalogue record ([a1b640e](https://github.com/nla/nla-arclight/commit/a1b640e537fea4c6b9947af860bb1f7ed4344675))


### Bug Fixes

* Add links to header ([6db6009](https://github.com/nla/nla-arclight/commit/6db6009b41df055eba825dd177e376745598e688))


### Code Refactoring

* change catalogue link wording and styling ([22e662e](https://github.com/nla/nla-arclight/commit/22e662e2222bb92b7f7913d57f6f4c1d29c96cf6))


### Miscellaneous

* prepare for next sprint ([1699aa3](https://github.com/nla/nla-arclight/commit/1699aa3d429166e6b505ce1f9dda4331edcf44bc))
* prepare Sprint 4 release ([2d8370c](https://github.com/nla/nla-arclight/commit/2d8370c691e6c000013987097b182023cc28415a))
* remove unnecessary NodeJS files ([b57333a](https://github.com/nla/nla-arclight/commit/b57333adaec0fed59660dd2c82386eebeaeed98b))
* resolve release merge back into main ([9ee551b](https://github.com/nla/nla-arclight/commit/9ee551b9c0c9a829f401d29f9d71331829c3f221))
* update blacklight_common dependency ([9f64494](https://github.com/nla/nla-arclight/commit/9f64494730a4182b91c3359874d4370d36d7144c))
* update Bundler version in Gemfile.lock ([3c4635d](https://github.com/nla/nla-arclight/commit/3c4635d4504810220468d4656f889abf2cd0d085))
* update dependencies ([0bdee9f](https://github.com/nla/nla-arclight/commit/0bdee9f4f2d7c5d799fc8849f93a276f57eada28))
* update nla-blacklight_common dependency ([66724f4](https://github.com/nla/nla-arclight/commit/66724f474ec69beb5ccf7193da822197ba5a0d13))

## [2.1.0](https://github.com/nla/nla-arclight/compare/2.0.0...2.1.0) (2023-06-30)


### Features

* adds Sign up link to header nav ([d352ab0](https://github.com/nla/nla-arclight/commit/d352ab02393baccaa6b638a69f409f7d328886d2))
* disable request and download links ([6656998](https://github.com/nla/nla-arclight/commit/6656998311c5b1271d59fcd6e8d6d607533f2015))
* ensure login redirects back to last visited page ([2a5a6b6](https://github.com/nla/nla-arclight/commit/2a5a6b61c9a28f58d49c093d5adc428216bcd51c))


### Bug Fixes

* add NLA favicon ([2387b04](https://github.com/nla/nla-arclight/commit/2387b043cd4ec0405cba02dd2e4dd6e71922ac69))
* change display of “Start over” and “Back to search” ([2b9af91](https://github.com/nla/nla-arclight/commit/2b9af918ed2d2fb5c96aacc2861c27c47db4d27c))
* fix header nav ([0117ff0](https://github.com/nla/nla-arclight/commit/0117ff013082ef80e6b978ce66e371c1c24117d2))


### Continuous Integration

* add workflow for sprint 3 release ([3410a28](https://github.com/nla/nla-arclight/commit/3410a2821676176a2aa818b77398b504c916f2f7))


### Miscellaneous

* finalise sprint 3 release ([4952ddf](https://github.com/nla/nla-arclight/commit/4952ddf5928bac4f46be2a0fd6d19964c825a5a0))
* point dependencies back to "main" branch ([08f70e7](https://github.com/nla/nla-arclight/commit/08f70e7054a56001055320a492b62d3f3e7056ab))
* upgrade bundler ([defabca](https://github.com/nla/nla-arclight/commit/defabca97119e743864393b1eab523fef4273333))
* upgrade dependencies and increase test coverage ([8382090](https://github.com/nla/nla-arclight/commit/838209032e87e52e7daccef78fe8039f426c5c6c))
* upgrade JS deps and re-organise scripts ([9fe6982](https://github.com/nla/nla-arclight/commit/9fe698228e2ed1a7ad7079702a613334a3a7d36f))

## [2.0.0](https://github.com/nla/nla-arclight/compare/1.0.2...2.0.0) (2023-06-13)


### ⚠ BREAKING CHANGES

* use nla-blacklight_common

### Features

* use nla-blacklight_common ([4b0639c](https://github.com/nla/nla-arclight/commit/4b0639c26ac5a82f51ed84429c29eead93033242))


### Bug Fixes

* add lower bar to header for application name ([3f6d85d](https://github.com/nla/nla-arclight/commit/3f6d85d65883788ae2fd96d8947902f42a9378f6))
* change highlight colour ([012b13a](https://github.com/nla/nla-arclight/commit/012b13a93b1aba7681f7b2f644b0f10d3c713265))
* change search term highlight colour ([535eb63](https://github.com/nla/nla-arclight/commit/535eb63531d7d9c8ec3b8b70a87735995b72ecf1))
* link record stylesheet ([a6eefea](https://github.com/nla/nla-arclight/commit/a6eefeaaaf97516e95e6e35687132e7e05e8043b))
* remove expand on bottombar ([197ce74](https://github.com/nla/nla-arclight/commit/197ce74ccbc67bdf326dedffc4c64a6ef0f9a1fe))
* remove sticky header rule for “environment bar” ([0a6f713](https://github.com/nla/nla-arclight/commit/0a6f7137bea18c3deb3210d55b1233ee26191c9d))
* reposition and style navbar actions ([c088da2](https://github.com/nla/nla-arclight/commit/c088da2e8eadb0016ffc31d1b7419fbdd61924c9))
* resolve merge collisions ([dd7accc](https://github.com/nla/nla-arclight/commit/dd7accc5f1ad69711637ccab1341e68c2d33dde5))
* update icon colour to light purple ([dd08a68](https://github.com/nla/nla-arclight/commit/dd08a68052813527745b63aa260207ed473452b5))


### Build System

* update version of bundler in Gemfile.lock ([96a5ea9](https://github.com/nla/nla-arclight/commit/96a5ea9c630708eb4cd05e1f4109a6abd168e1ca))


### Styles

* fix rubocop error ([fe8ca67](https://github.com/nla/nla-arclight/commit/fe8ca670d2a98e7c412d7fa27ded994c5f01f916))


### Miscellaneous

* bump version ([c0b1454](https://github.com/nla/nla-arclight/commit/c0b1454beac54098280835c68e4e2837ee7b2fd7))
* merge release 1.0.2 back into main ([7593d1c](https://github.com/nla/nla-arclight/commit/7593d1c3b18cbd07717797d91585c9d069c09ad3))
* prepare release ([b364a28](https://github.com/nla/nla-arclight/commit/b364a283d6abe5e35f8d2261af7570c0b7380a1b))
* upgrade dependencies ([d1d698e](https://github.com/nla/nla-arclight/commit/d1d698ed736a90fda7dfc57decbe0f237a0bc1b2))
* upgrade dependencies ([1d45eda](https://github.com/nla/nla-arclight/commit/1d45eda54f51b5a0055e30ae79e0b2342982f41f))

## [1.0.2](https://github.com/nla/nla-arclight/compare/1.0.1...1.0.2) (2023-05-30)


### Bug Fixes

* change colour of online icon ([098b05e](https://github.com/nla/nla-arclight/commit/098b05e04a1059f7a7e3210748f72df648b6a400))
* display facets on the right hand side of results ([402a83c](https://github.com/nla/nla-arclight/commit/402a83c6fd8b692b6006f536e5852d437e51ed4f))
* fix catalogue-patrons version ([8c203ad](https://github.com/nla/nla-arclight/commit/8c203adf95d60a0df1febce91f81ddd576c20e2b))
* make selected tab clear ([95ae9c8](https://github.com/nla/nla-arclight/commit/95ae9c8859bb1165bd26d1e54fac12c5b544fa76))
* search term highlighting in arclight results ([cfdb510](https://github.com/nla/nla-arclight/commit/cfdb510c8322eaca68de845649a3b3ed5a51a4a1))
* Style pagination at top and bottom of search results ([8ef80f5](https://github.com/nla/nla-arclight/commit/8ef80f53f9a82466ea8544ea1935438b437d016d))
* Style result tools (eg sortby) ([cd1e575](https://github.com/nla/nla-arclight/commit/cd1e5750f51a1eb1ae6fb5093abe81c77b2f4422))
* style search result limits as pills ([6516ff5](https://github.com/nla/nla-arclight/commit/6516ff5dc2c053edb9af0d8e789fa4df1a433f38))
* style view online link to be button (would be better to assign btn CSS class to &lt;a&gt;) ([2510c72](https://github.com/nla/nla-arclight/commit/2510c72d574a6583611a8459a9d31ec67a0ca016))
* update online icon colour ([fb8b971](https://github.com/nla/nla-arclight/commit/fb8b97106ac2772824523bd650b3ababc73842c0))


### Reverts

* manually revert BLAC-308 ([46a31f9](https://github.com/nla/nla-arclight/commit/46a31f95db9ab8a478b695f41e226b55f319730f))


### Miscellaneous

* cleanup code coverage ([11735e9](https://github.com/nla/nla-arclight/commit/11735e97046fd96671ae75185eafc3f4f1e672f8))
* integrate renaming of staff shared login ([a905d16](https://github.com/nla/nla-arclight/commit/a905d1600b3cb472b35f55d4858b79a47fb47ee8))
* prepare release ([42de443](https://github.com/nla/nla-arclight/commit/42de4433fd7335e30ae3046ecd5ee842a00c75d4))
* resolve hotfix changes into main ([00f73b7](https://github.com/nla/nla-arclight/commit/00f73b75412a6f9b2ce0bb1ec97c01f81c217708))
* upgrade gems and yarn packages ([ff3f10e](https://github.com/nla/nla-arclight/commit/ff3f10ee3866d67f451be8306dc5280abb890ec6))


### Continuous Integration

* add release workflow for non-standard release ([e66094e](https://github.com/nla/nla-arclight/commit/e66094e7ffaa12583ce62aae4faf55c65fe5de19))
* fix default branch ([5328137](https://github.com/nla/nla-arclight/commit/5328137cefc193a03cbba64d824201ae6bf2031f))

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
