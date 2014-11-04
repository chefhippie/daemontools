#
# Cookbook Name:: daemontools
# Provider:: app
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "chef/dsl/include_recipe"
include Chef::DSL::IncludeRecipe

require "chef/mixin/command"
require "chef/mixin/language"
include Chef::Mixin::Command

action :enable do
  if svc_disabled?



    new_resource.updated_by_last_action(true)
  end
end

action :disable do
  if svc_enabled?
    link svc_roots.first do
      action :delete
    end

    svc_execute "-dx"
    new_resource.updated_by_last_action(true)
  end
end

action :start do
  if svc_running?
    svc_execute "-u"
    new_resource.updated_by_last_action(true)
  end
end

action :stop do
  if svc_running?
    svc_execute "-d"
    new_resource.updated_by_last_action(true)
  end
end

action :restart do
  if svc_running?
    svc_execute "-du"
    new_resource.updated_by_last_action(true)
  end
end

action :up do
  if svc_running?
    svc_execute "-u"
    new_resource.updated_by_last_action(true)
  end
end

action :down do
  if svc_running?
    svc_execute "-d"
    new_resource.updated_by_last_action(true)
  end
end

action :once do
  if svc_running?
    svc_execute "-o"
    new_resource.updated_by_last_action(true)
  end
end

action :pause do
  if svc_running?
    svc_execute "-p"
    new_resource.updated_by_last_action(true)
  end
end

action :cont do
  if svc_running?
    svc_execute "-c"
    new_resource.updated_by_last_action(true)
  end
end

action :hup do
  if svc_running?
    svc_execute "-h"
    new_resource.updated_by_last_action(true)
  end
end

action :alarm do
  if svc_running?
    svc_execute "-a"
    new_resource.updated_by_last_action(true)
  end
end

action :int do
  if svc_running?
    svc_execute "-i"
    new_resource.updated_by_last_action(true)
  end
end

action :term do
  if svc_running?
    svc_execute "-t"
    new_resource.updated_by_last_action(true)
  end
end

action :kill do
  if svc_running?
    svc_execute "-k"
    new_resource.updated_by_last_action(true)
  end
end

def svc_execute(command)
  execute "daemontools_#{new_resource.name}_#{command.sub("-", "")}" do
    command "svc #{command} #{svc_roots.join(" ")}"
    cwd svc_directory.to_s
    action :run

    user new_resource.owner
    group new_resource.group || new_resource.owner

    only_if do
      svc_running?
    end
  end
end

def svc_local?
  new_resource.owner != "root"
end

def svc_running?
  @svc_running ||= begin
    if run_command_with_systems_locale(:command => "svok #{svc_roots.first}") == 0
      true
    else
      false
    end
  rescue Chef::Exceptions::Exec
    false
  end
end

def svc_enabled?
  @svc_enabled ||= svc_roots.first.symlink? and svc_roots.first.join("run").file?
end

def svc_disabled?
  @svc_disabled ||= not svc_roots.first.symlink? and not svc_roots.first.join("run").file?
end



def svc_roots
  [
    Pathname.new
  ]
end

def svc_directory
  Pathname.new
end
