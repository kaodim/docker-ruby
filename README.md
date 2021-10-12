## Description

A repo to build Ruby container. The container image only contains essential apt package. For dated Ruby (< 2.4.0) that is built on top of recent ubuntu release (>= 20.04), some ruby version manager like `rvm` will be used as there will be build error due to package incompatibility when we build Ruby from scratch.

Currently support the following versions:

1. ruby-231 on ubuntu 20.04

## Things to note

1. For Ruby containers that rely on `RVM`, login bash command is required should you want to run any Ruby command in an non-interactive shell session. In fact, this is the most common run pattern as most Ruby processes are started by doing `bundle exec rails server` or `bundle exec sidekiq start` and etc during deployment. These commands will not work in `RVM` managed Ruby unless you fired it in this fashion, `bash -lc "bundle exec sidekiq start"`. This is due to the fact that `RVM` Ruby version selector is implemented as a bash function and it will be loaded from the `.bash_profile` under login shell session. So if your Ruby process is required to be run under different user (other than `root`), please check if the dedicated user can invoke the `rvm` function after login.

## Branching strategy

As we are managing different flavours of Ruby in a single repo, we will be managing those flavours using branch name.

Say we want to create a Ruby build for `ruby-250-ubuntu2004`. The following steps are required:

1. Create a dev branch with sensible name such as `ruby-250-ubuntu2004`
2. Create a test branch named as `test/ruby-250-ubuntu2004`
3. Create a master branch named as `masters/ruby-250-ubuntu2004`
4. Create a PR the dev branch to `masters/ruby-250-ubuntu2004`
5. Add the new build config to the config file. See [CI](#ci) section for how to configure a CI for a new flavour.
6. Start developing and generate a test build by merging into `test/ruby-250-ubuntu2004`.
7. Once its tested, merge the PR.
8. Repeat step 1-7 if you need to deliver more patch to the same flavour. (config setup only needs to be done once when the flavour is first created)

## Image tagging convention

Image tag is constructed by joining all the namespaces with `_`. Say we want to want a tag to carry the information of ruby version, os version, the tag will be something like `ruby-231_ubuntu-2004`.

## CI

To create a new ruby flavour build, create a properly namespaced directory and put your `Dockerfile` inside there. You don't have to prepend `masters` or `tests` to the branch name as this will be handled during build time.

```yaml
"ruby-231/ubuntu2004":          # => this is the branch name
  target: "ruby_231/ubuntu2004" # => this is the target path of the Dockerfile
  ruby_version: ruby-231             # => these are the meta info of the container image 
  os_version: ubuntu-2004
  ruby_manager: rvm
  tags:                         # => these are the tags that you want to use for the build image. The values will be extracted from the parent level
    - ruby_version
    - os_version
    - ruby_manager
```

Automated CI is setup branches with name starting with `masters/` or `test/`. For example, changes in branch `masters/foo` will trigger new build, but changes in branch `foo` will not.