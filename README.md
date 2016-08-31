# Proof of concept for using ruby-lapack on Heroku

## installing ruby-lapack locally on OSX

```
$ brew install narray
$ gem install narray
$ gem install ruby-lapack -- --with-narray-include="$GEM_HOME/gems/narray-0.6.1.2/"

# You can get the source from here
# git clone http://ruby.gfd-dennou.org/products/ruby-lapack/ruby-lapack.git
```

## installing ruby-lapack on Heroku

The following buildpack contains a built library for lapack

    heroku buildpacks:add --index 1 https://github.com/thenovices/heroku-buildpack-scipy

But to get this to work you'll need to add a requirements.txt file to the root of the project like so:

    echo -e "numpy==1.9.2\nscipy==0.15.1" > requirements.txt

Once that buildpack is in place, you need to specify the correct flags for bundler so that it can find the libraries when installing the gem.
Bundler (the Ruby gem manager) accepts a special environment variable in the form `BUNDLE_BUILD__***` which allows you to set those flags.
Environment variables on Heroku are controlled with the heroku `config` command. Anyway, the command should be the following:

    heroku config:set BUNDLE_BUILD__RUBY-LAPACK="--with-lapack-lib=/app/.heroku/vendor/lib/atlas-base/atlas/ --with-narray-include=`gem which narray | sed 's/narray.so//g'`"

That should allow the `ruby-lapack` gem to find the right library for lapack and the right header file for `narray`.
