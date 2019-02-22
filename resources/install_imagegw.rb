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
property :imagegw_fqdn, String, default: nil

action :install do
  shifter_compile 'shifter_install' do
    cookbook new_resource.cookbook
    config_dir new_resource.config_dir
    udiroot new_resource.udiroot
    git_repo new_resource.git_repo
    version new_resource.version
    with_slurm new_resource.with_slurm
    slurm_dir new_resource.slurm_dir
    extract_dir new_resource.extract_dir
    imagegw_fqdn new_resource.imagegw_fqdn
    not_if { ::File.exist?(new_resource.udiroot + '/bin/shifterimg') }
  end

  link "#{new_resource.udiroot}/bin/shifterimg" do
    to '/usr/bin/shifterimg'
  end
end

action :uninstall do
  link "#{new_resource.udiroot}/bin/shifterimg" do
    to '/usr/bin/shifterimg'
    action :delete
  end
end
