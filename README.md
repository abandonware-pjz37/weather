Simple cross-platform open source weather by city application. Hunter package manager usage example.

### Used service

* http://openweathermap.org/api

### C/C++ core

* [Boost](http://www.boost.org/)
* [Sober](http://github.com/ruslo/sober)
* [CppNetlib.URI](https://github.com/cpp-netlib/uri)
* [GTest](http://code.google.com/p/googletest/)
* [JSONSpirit](https://github.com/cierelabs/json_spirit)

### Build system

* [CMake](http://cmake.org/)
 * with modules:
  * [Sugar](https://github.com/ruslo/sugar) - tools, wrappers, workarounds, ...
  * [Polly](https://github.com/ruslo/polly) - toolchain files
  * [Hunter](https://github.com/ruslo/hunter) - package manager

### Requirements

* CMake version 3.0 ([more](https://github.com/ruslo/hunter/wiki/Requirements#cmake-30))
* `HUNTER_ROOT` environment variable ([more](https://github.com/ruslo/hunter/wiki/Requirements#hunter_root))
* Python 3 (For `Xcode` and `Visual Studio` based projects)
* `POLLY_ROOT` environment variable ([more](https://github.com/ruslo/hunter/wiki/Requirements#toolchains-example-polly))

### Usage

*Note* that a lot of time (> 1 hour) and space (> 1 GB) may be required for build, so be patient and
consider test this [tiny-project](https://github.com/forexample/hunter-simple) before run.

#### Download and unpack

Download and unpack current release archive and cd to unpacked directory.
Unix-style:

```
> wget https://github.com/ruslo/weather/archive/v1.2.0.tar.gz
> tar xf v1.2.0.tar.gz
> cd weather-1.2.0
```

##### Windows (Visual Studio, tested with 2013 32/64)

* Run cmd and check cmake version, `HUNTER_ROOT` environment, python 3:
```
> where cmake
/path/to/cmake
> cmake --version
cmake version 3.0.0
> where python
/path/to/python.exe
> python --version
Python 3.x.x
> echo %HUNTER_ROOT%
/path/to/hunter/root
```
* Start build:
```
> cmake -H. -B_builds -DHUNTER_STATUS_DEBUG=ON -G"Visual Studio 12 2013 Win64"
```

##### Linux

* Check cmake version, `HUNTER_ROOT` and `POLLY_ROOT` environment variables:
```
> which cmake
/path/to/cmake
> cmake --version
cmake version 3.0.0
> echo $HUNTER_ROOT
/path/to/hunter/root/
> echo $POLLY_ROOT
/path/to/toolchains
```

* Pick toolchain with `c++11` support, for example [gcc](https://github.com/ruslo/polly/wiki/Toolchain-list#gcc)
(`gcc -std=c++11`):
```
> ls $POLLY_ROOT/gcc.cmake
/path/to/toolchains/gcc.cmake
```

* Start build:
```
> cmake -H. -B_builds -DHUNTER_STATUS_DEBUG=ON -DCMAKE_TOOLCHAIN_FILE=$POLLY_ROOT/gcc.cmake
```


### iOS

[![AppStore][appstore_logo]][weather_link]

[appstore_logo]: https://linkmaker.itunes.apple.com/htmlResources/assets/en_us//images/web/linkmaker/badge_appstore-lrg.svg
[weather_link]: https://itunes.apple.com/us/app/weather-with-hunter/id885350236?mt=8&uo=4
