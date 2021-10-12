## Description

A repo to build Ruby container. The container image only contains essential apt package. For dated Ruby (< 2.4.0) that is built on top of recent ubuntu release (>= 20.04), some ruby version manager like `rvm` will be used as there will be build error due to package incompatibility when we build Ruby from scratch.

Currently support the following versions:

1. ruby-231 on ubuntu 20.04

## Things to note

1. For Ruby containers that rely on `RVM`, login bash command is required should you want to run any Ruby command in an non-interactive shell session. In fact, this is the most common run pattern as most Ruby processes are started by doing `bundle exec rails server` or `bundle exec sidekiq start` and etc during deployment. These commands will not work in `RVM` managed Ruby unless you fired it in this fashion, `bash -lc "bundle exec sidekiq start"`. This is due to the fact that `RVM` Ruby version selector is implemented as a bash function and it will be loaded from the `.bash_profile` under login shell session. So if your Ruby process is required to be run under different user (other than `root`), please check if the dedicated user can invoke the `rvm` function after login.
