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
          '< 9' => %w(
            gcc
            git
            unzip
            libjson-c-dev
            libjson-c2
            libmunge2
            libmunge-dev
            libslurm-dev
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
          '>= 9' => %w(
            gcc
            git
            unzip
            libjson-c-dev
            libjson-c3
            libmunge2
            libmunge-dev
            libslurm-dev
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
            gcc
            git
            unzip
            libjson-c-dev
            libjson-c2
            libmunge2
            libmunge-dev
            libslurm-dev
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
            gcc
            git
            unzip
            libjson-c-dev
            libjson-c3
            libmunge2
            libmunge-dev
            libslurm-dev
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
            git
            gcc
            glibc-devel
            munge
            libcurl-devel
            slurm-devel
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

    def shifter_imagegw_packages
      value_for_platform(
        'debian' => {
          '< 9' => %w(
            mongodb-server
            squashfs-tools
            python-pymongo
            python-flask
            pylint
            gunicorn
            redis-server
            python-redis
          ),
          '>= 9' => %w(
            mongodb-server
            squashfs-tools
            python-pymongo
            python-flask
            pylint
            gunicorn
            redis-server
            python-redis
          ),

        },
        'ubuntu' => {
          '< 18.04' => %w(
            mongodb-server
            squashfs-tools
            python-pymongo
            python-flask
            pylint
            gunicorn
            redis-server
            python-redis
          ),
          '>= 18.04' => %w(
            mongodb-server
            squashfs-tools
            python-pymongo
            python-flask
            pylint
            gunicorn
            redis-server
            python-redis
          ),

        },
        %w(centos redhat suse fedora) => {
          'default' => %w(
            mongodb-server
            squashfs-tools
            python-pymongo
            python-flask
            python-gunicorn
            redis
            python-redis
          ),
        }
      )
    end

    def shifter_config_dir
      '/etc/shifter'
    end

    def shifter_udiroot_dir
      '/opt/shifter/udiRoot'
    end

    def shifter_git_repo
      'https://github.com/NERSC/shifter.git'
      # 'https://github.com/t0rrant/shifter.git'
    end

    def shifter_version_stable
      # '18.03.0'
      'master'
    end

    def shifter_etc_files_dir
      "#{shifter_config_dir}/shifter_etc_files"
    end

    def shifter_image_dir
      '/home/shifter/images'
    end

    def shifter_expand_dir
      '/var/opt/shifter/images'
    end

    def shifter_system_name
      (!node['shifter'].nil? && !node['shifter']['system'].nil?) ? node['shifter']['system'] : node['hostname']
    end

    def systemd_service_dir
      '/etc/systemd/system/'
    end
  end
end
