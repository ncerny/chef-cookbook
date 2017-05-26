#
# Cookbook Name:: chef_stack
# Library:: helpers
#
# Copyright 2016 Chef Software Inc
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

def prefix
  (platform_family?('windows') ? 'C:/Chef/' : '/etc/chef/')
end

def ensurekv(original_config, hash)
  config = original_config.dup
  hash.each do |k, v|
    if v.is_a?(Symbol)
      v = v.to_s
      str = v
    else
      str = "'#{v}'"
    end
    if config =~ /^ *#{v}.*$/
      config.sub!(/^ *#{v}.*$/, "#{k} #{str}")
    else
      config << "\n#{k} #{str}"
    end
  end
  config
end

def deprecation_notice
  message = 'Chef Stack is deprecated.  The resources have been merged into chef-ingredient.  Please update your cookbooks to use chef-ingredient.'
  log 'Deprecation' do
    level :warn
    message message
  end
  Chef.deprecated(:internal_api, message)
end
