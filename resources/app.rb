#
# Cookbook Name:: daemontools
# Resource:: app
#
# Copyright 2013, Thomas Boerger
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

actions :start, :stop, :status, :restart, :up, :down, :once, :pause, :cont, :hup, :alrm, :int, :term, :kill, :enable, :disable

attribute :name, :kind_of => String, :name_attribute => true







attribute :directory, :kind_of => String, :required => true
attribute :template, :kind_of => [String, FalseClass], :default => :service_name
attribute :cookbook, :kind_of => String
attribute :enabled, :default => false
attribute :running, :default => false
attribute :variables, :kind_of => Hash, :default => {}
attribute :owner, :regex => Chef::Config['user_valid_regex']
attribute :group, :regex => Chef::Config['group_valid_regex']
attribute :finish, :kind_of => [TrueClass, FalseClass]
attribute :log, :kind_of => [TrueClass, FalseClass]
attribute :env, :kind_of => Hash, :default => {}







default_action :start
