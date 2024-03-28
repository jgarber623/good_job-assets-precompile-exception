# README

Conditions:

1. Ruby v3.1.4 (possibly unrelated)
2. Ruby on Rails v6.1.7.7 (possibly unrelated)
3. GoodJob gem v3.27.2
4. No `config/database.yml` (Rails supports `DATABASE_URL` in lieu of this configuration file)

This repository uses a Dockerfile to demonstrate an exception raised when precompiling assets after adding [GoodJob](https://rubygems.org/gems/good_job) to the project.

```sh
docker build --build-arg SECRET_KEY_BASE=032f3884ff8e160a483428f9c4b1dbc0 --tag good_job-assets-precompile-exception:latest .
```

The above command will throw an exception which appears to originate from `lib/good_job/engine.rb:56`:

```
Could not load database configuration. No such file - ["config/database.yml"]
```

> [!NOTE]
> It's likely possible to trigger the same error using a locally installed Ruby and running an equivalent command like `RAILS_ENV=production SECRET_KEY_BASE=032f3884ff8e160a483428f9c4b1dbc0 bundle exec rake assets:precompile`. The use of Docker was my quickest way of demonstrating the unexpected behavior.

An undesirable workaround is to set `DATABASE_URL` to a bogus value in the Dockerfile before precompiling assets, though there might be unknown side effects depending on configuration.

<details>
<summary>🪵 Click for full log</summary>

```txt
[+] Building 42.0s (9/9) FINISHED                                                                                      docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                   0.0s
 => => transferring dockerfile: 462B                                                                                                   0.0s
 => [internal] load metadata for docker.io/library/ruby:3.1.4-bookworm                                                                 0.2s
 => [internal] load .dockerignore                                                                                                      0.0s
 => => transferring context: 2B                                                                                                        0.0s
 => [1/5] FROM docker.io/library/ruby:3.1.4-bookworm@sha256:ec69284bcbceb0a23ffc070ef2e0e8eb0fe495c20efbd51846b103338c3da1e4           0.0s
 => [internal] load build context                                                                                                      0.0s
 => => transferring context: 14.85kB                                                                                                   0.0s
 => CACHED [2/5] WORKDIR /usr/src/app                                                                                                  0.0s
 => [3/5] COPY . .                                                                                                                     0.0s
 => [4/5] RUN bundle install                                                                                                          40.7s
 => ERROR [5/5] RUN bundle exec rake assets:precompile                                                                                 1.1s 
------                                                                                                                                      
 > [5/5] RUN bundle exec rake assets:precompile:                                                                                            
1.036 rake aborted!                                                                                                                         
1.036 Cannot load database configuration:                                                                                                   
1.036 Could not load database configuration. No such file - ["config/database.yml"]                                                         
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application/configuration.rb:294:in `database_configuration'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activerecord-6.1.7.7/lib/active_record/railtie.rb:221:in `block (2 levels) in <class:Railtie>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:71:in `class_eval'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:71:in `block in execute_hook'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:61:in `with_execution_control'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:66:in `execute_hook'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:52:in `block in run_load_hooks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:51:in `each'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:51:in `run_load_hooks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activerecord-6.1.7.7/lib/active_record/base.rb:315:in `<module:ActiveRecord>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activerecord-6.1.7.7/lib/active_record/base.rb:15:in `<main>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/bootsnap-1.18.3/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/bootsnap-1.18.3/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/zeitwerk-2.6.13/lib/zeitwerk/kernel.rb:34:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/good_job-3.27.2/lib/good_job/engine.rb:56:in `block (2 levels) in <class:Engine>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:68:in `block in execute_hook'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:61:in `with_execution_control'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:66:in `execute_hook'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:52:in `block in run_load_hooks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:51:in `each'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:51:in `run_load_hooks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application/finisher.rb:140:in `block in <module:Finisher>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/initializable.rb:32:in `instance_exec'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/initializable.rb:32:in `run'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/initializable.rb:61:in `block in run_initializers'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/initializable.rb:60:in `run_initializers'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application.rb:391:in `initialize!'
1.036 /usr/src/app/config/environment.rb:5:in `<main>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/bootsnap-1.18.3/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/bootsnap-1.18.3/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/zeitwerk-2.6.13/lib/zeitwerk/kernel.rb:34:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/dependencies.rb:332:in `block in require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/dependencies.rb:299:in `load_dependency'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/dependencies.rb:332:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application.rb:367:in `require_environment!'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application.rb:533:in `block in run_tasks_blocks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/sprockets-rails-3.4.2/lib/sprockets/rails/task.rb:61:in `block (2 levels) in define'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/rake-13.1.0/exe/rake:27:in `<top (required)>'
1.036 /usr/local/bin/bundle:25:in `load'
1.036 /usr/local/bin/bundle:25:in `<main>'
1.036 
1.036 Caused by:
1.036 Could not load database configuration. No such file - ["config/database.yml"]
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application/configuration.rb:294:in `database_configuration'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activerecord-6.1.7.7/lib/active_record/railtie.rb:221:in `block (2 levels) in <class:Railtie>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:71:in `class_eval'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:71:in `block in execute_hook'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:61:in `with_execution_control'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:66:in `execute_hook'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:52:in `block in run_load_hooks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:51:in `each'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:51:in `run_load_hooks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activerecord-6.1.7.7/lib/active_record/base.rb:315:in `<module:ActiveRecord>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activerecord-6.1.7.7/lib/active_record/base.rb:15:in `<main>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/bootsnap-1.18.3/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/bootsnap-1.18.3/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/zeitwerk-2.6.13/lib/zeitwerk/kernel.rb:34:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/good_job-3.27.2/lib/good_job/engine.rb:56:in `block (2 levels) in <class:Engine>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:68:in `block in execute_hook'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:61:in `with_execution_control'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:66:in `execute_hook'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:52:in `block in run_load_hooks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:51:in `each'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/lazy_load_hooks.rb:51:in `run_load_hooks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application/finisher.rb:140:in `block in <module:Finisher>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/initializable.rb:32:in `instance_exec'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/initializable.rb:32:in `run'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/initializable.rb:61:in `block in run_initializers'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/initializable.rb:60:in `run_initializers'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application.rb:391:in `initialize!'
1.036 /usr/src/app/config/environment.rb:5:in `<main>'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/bootsnap-1.18.3/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/bootsnap-1.18.3/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/zeitwerk-2.6.13/lib/zeitwerk/kernel.rb:34:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/dependencies.rb:332:in `block in require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/dependencies.rb:299:in `load_dependency'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/activesupport-6.1.7.7/lib/active_support/dependencies.rb:332:in `require'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application.rb:367:in `require_environment!'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/railties-6.1.7.7/lib/rails/application.rb:533:in `block in run_tasks_blocks'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/sprockets-rails-3.4.2/lib/sprockets/rails/task.rb:61:in `block (2 levels) in define'
1.036 /usr/src/app/vendor/bundle/ruby/3.1.0/gems/rake-13.1.0/exe/rake:27:in `<top (required)>'
1.036 /usr/local/bin/bundle:25:in `load'
1.036 /usr/local/bin/bundle:25:in `<main>'
1.036 Tasks: TOP => environment
1.036 (See full trace by running task with --trace)
------
Dockerfile:19
--------------------
  17 |     RUN bundle install
  18 |     
  19 | >>> RUN bundle exec rake assets:precompile
  20 |     
  21 |     # docker build --build-arg SECRET_KEY_BASE=032f3884ff8e160a483428f9c4b1dbc0 --tag good_job-assets-precompile-exception:latest .
--------------------
ERROR: failed to solve: process "/bin/sh -c bundle exec rake assets:precompile" did not complete successfully: exit code: 1
```

</details>
