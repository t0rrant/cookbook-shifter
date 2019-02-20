#
# Cookbook:: shifter
# Library:: helpers
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
#

module ShifterCookbook
  module Helpers
    include Chef::Mixin::ShellOut

    def required_packages
      if platform_family?('debian')
        %w(
          unzip
          libjson-c2
          libjson-c-dev
          libmunge2
          libmunge-dev
          libcurl4-openssl-dev
          autoconf
          automake
          libtool
          curl
          make
          xfsprogs
          python-dev
          libcap-dev
          wget
        )
      elsif platform_family?('redhat')
        %w(
          gcc
          glibc-devel
          munge
          libcurl-devel
          json-c
          json-c-devel
          pam-devel
          munge-devel
          libtool
          autoconf
          automake
          gcc-c++
          xfsprogs
          python-devel
          libcap-devel
        )
      end
    end
  end
end
