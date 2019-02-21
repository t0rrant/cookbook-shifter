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
      value_for_platform(
        'debian' => {
          'default' => %w(
            unzip
            libjson-c-dev
            libjson-c3
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
          ),

        },
        'ubuntu' => {
          '< 18.04' => %w(
            unzip
            libjson-c-dev
            libjson-c2
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
          ),
          '>= 18.04' => %w(
            unzip
            libjson-c-dev
            libjson-c3
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
          ),

        },
        %w(centos redhat suse fedora) => {
          'default' => %w(
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
          ),
        }
      )
    end
  end
end
