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
property :system_name, String, default: lazy { shifter_system_name }
property :image_path, String, default: lazy { shifter_image_dir }
property :imagegw_fqdn, [nil, String], default: nil
property :siteenv_append, String, default: 'PATH=/opt/udiImage/bin'

action :install do
  shifter_compile 'Compile and Install Shifter components' do
    cookbook new_resource.cookbook
    config_dir new_resource.config_dir
    udiroot new_resource.udiroot
    git_repo new_resource.git_repo
    version new_resource.version
    with_slurm new_resource.with_slurm
    slurm_dir new_resource.slurm_dir
    system_name new_resource.system_name
    extract_dir new_resource.extract_dir
    imagegw_fqdn new_resource.imagegw_fqdn
    siteenv_append new_resource.siteenv_append
    not_if { ::File.exist?(new_resource.udiroot + '/bin/shifter') }
  end

  link '/usr/bin/shifter' do
    to "#{new_resource.udiroot}/bin/shifter"
    not_if { ::File.exist?('/usr/bin/shifter') }
  end

  link '/usr/bin/shifterimg' do
    to "#{new_resource.udiroot}/bin/shifterimg"
    not_if { ::File.exist?('/usr/bin/shifterimg') }
  end

  template "#{new_resource.config_dir}/premount.sh" do
    source 'premount.sh'
    mode '755'
    cookbook new_resource.cookbook
  end

  template "#{new_resource.config_dir}/postmount.sh" do
    source 'postmount.sh'
    mode '755'
    cookbook new_resource.cookbook
  end

  template '/etc/profile.d/00-shifter_aliases.sh' do
    source 'aliases.sh'
    mode '644'
    cookbook new_resource.cookbook
  end

  %w(passwd group).each do |file|
    link "#{new_resource.shifter_etc_files}/#{file}" do
      to "/etc/#{file}"
    end
  end
end

action :uninstall do
  link '/usr/bin/shifter' do
    to "#{new_resource.udiroot}/bin/shifter"
    action :delete
  end

  link '/usr/bin/shifterimg' do
    to "#{new_resource.udiroot}/bin/shifterimg"
    action :delete
  end
end
