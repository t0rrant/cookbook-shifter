property :cookbook, String, default: 'shifter'
property :config_dir, String, default: '/etc/shifter'
property :udiroot, String, default: '/opt/shifter/udiRoot'
property :git_repo, String, default: 'https://github.com/NERSC/shifter.git'
property :version, String, default: '18.03.0'
property :with_slurm, [true, false], default: false
property :slurm_dir, String, default: '/usr'
property :extract_dir, String, default: '/tmp'
property :shifter_etc_files, String, default: lazy { "#{config_dir}/shifter_etc_files" }
property :image_path, String, default: '/home/shifter/images'

action :install do
  shifter_compile 'shifter_install' do
    config_dir new_resource.config_dir
    udiroot new_resource.udiroot
    git_repo new_resource.git_repo
    version new_resource.version
    with_slurm new_resource.with_slurm
    slurm_dir new_resource.slurm_dir
    extract_dir new_resource.extract_dir
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
