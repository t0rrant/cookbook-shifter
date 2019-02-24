include ShifterCookbook::Helpers

property :cookbook, String, default: 'shifter'
property :extract_dir, String, default: '/tmp'
property :slurm_dir, String, default: '/usr'
property :with_slurm, [true, false], default: false
property :config_dir, String, default: lazy { shifter_config_dir }
property :udiroot, String, default: lazy { shifter_udiroot_dir }
property :git_repo, String, default: lazy { shifter_git_repo }
property :version, String, default: lazy { shifter_version_stable }
property :shifter_etc_files, String, default: lazy { shifter_etc_files_dir }
property :image_path, String, default: lazy { shifter_image_dir }
property :imagegw_fqdn, String, default: ''

action :install do
  required_packages.each(&method(:package))

  directory new_resource.udiroot do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
    not_if { ::File.directory?(new_resource.udiroot) }
  end

  directory '/usr/libexec/shifter' do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
    not_if { ::File.directory?('/usr/libexec/shifter') }
  end

  node.default['shifter']['system'] = node['hostname']

  template "#{new_resource.udiroot}/udiRoot.conf" do
    source 'udiRoot_conf.erb'
    cookbook new_resource.cookbook
    variables(
      image_dir: new_resource.image_path,
      udiRoot: new_resource.udiroot,
      premount_sh: "#{new_resource.config_dir}/premount.sh",
      postmount_sh: "#{new_resource.config_dir}/postmount.sh",
      shifter_etc_files: new_resource.shifter_etc_files,
      system_name: node['shifter']['system'],
      imagegw_fqdn: new_resource.imagegw_fqdn.empty? ? node['fqdn'] : new_resource.imagegw_fqdn
    )
  end

  directory new_resource.config_dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
    not_if { ::File.directory?(new_resource.config_dir) }
  end

  # tar_extract "https://github.com/NERSC/shifter/releases/download/#{new_resource.version}/shifter-#{new_resource.version}.tar.gz" do
  #   target_dir new_resource.extract_dir
  #   creates "#{new_resource.extract_dir}/shifter-#{new_resource.version}"
  # end

  git "#{new_resource.extract_dir}/shifter-#{new_resource.version}" do
    repository new_resource.git_repo
    revision "shifter-#{new_resource.version}" if new_resource.version != 'master'
  end

  configure_opts = "--prefix=#{new_resource.udiroot} --sysconfdir=#{new_resource.config_dir} --disable-staticsshd --with-json-c --with-libcurl --with-munge"
  configure_opts << "--with-slurm=#{new_resource.slurm_dir}" if new_resource.with_slurm

  bash 'configure and compile shifter' do
    # cwd "#{new_resource.extract_dir}/shifter-#{new_resource.version}"
    cwd "#{new_resource.extract_dir}/shifter-#{new_resource.version}"
    code <<-EOH
    ./autogen.sh
    ./configure #{configure_opts}
    make
    make install
    EOH
  end

  link "#{new_resource.udiroot}/libexec/shifter/mount" do
    to '/usr/libexec/shifter/mount'
  end
end

action :clean do
  directory new_resource.extract_dir do
    recursive true
    action :delete
  end
end

action :uninstall do
  directory '/usr/libexec/shifter' do
    recursive true
    action :delete
    only_if { ::File.directory?('/usr/libexec/shifter') }
  end

  link "#{new_resource.udiroot}/libexec/shifter/mount" do
    to '/usr/libexec/shifter/mount'
    action :delete
  end

  directory new_resource.config_dir do
    recursive true
    action :delete
    only_if { ::File.directory?(new_resource.config_dir) }
  end
end
