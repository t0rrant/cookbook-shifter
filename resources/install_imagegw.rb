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
property :expand_path, String, default: lazy { shifter_expand_dir }
property :imagegw_fqdn, [nil, String], default: nil

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

  shifter_imagegw_packages.each(&method(:package))

  directory "#{new_resource.image_path}/cache" do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
    not_if { ::File.directory?("#{new_resource.image_path}/cache") }
  end

  directory new_resource.expand_path do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
    not_if { ::File.directory?(new_resource.expand_path) }
  end

  template "#{new_resource.config_dir}/imagemanager.json" do
    source 'imagemanager.json.erb'
    cookbook new_resource.cookbook
    variables(
      image_dir: new_resource.image_path,
      expand_dir: new_resource.expand_path,
      cache_dir: "#{new_resource.image_path}/cache",
      system_name: system_name
    )
  end

  template "#{systemd_service_dir}/shifter_imagegw.service" do
    source 'shifter_imagegw.service.erb'
    cookbook new_resource.cookbook
    variables(
      shifter_udiroot_dir: shifter_udiroot_dir
    )
  end

  execute 'Systemd Daemon Reload' do
    command 'systemctl daemon-reload'
    action :run
  end

  link "#{new_resource.udiroot}/bin/shifterimg" do
    to '/usr/bin/shifterimg'
  end

  service 'Shifter Image Manager Service' do
    service_name 'shifter_imagegw'
    supports restart: true, status: true
    restart_command "systemctl restart #{service_name}"
    status_command "systemctl status #{service_name}"
    action :start
  end
end

action :uninstall do
  service 'Shifter Image Manager Service' do
    service_name 'shifter_imagegw'
    supports restart: true, status: true
    restart_command "systemctl restart #{service_name}"
    status_command "systemctl status #{service_name}"
    action :stop
  end

  file "#{systemd_service_dir}/shifter_imagegw.service" do
    action :delete
  end

  file "#{new_resource.config_dir}/imagemanager.json" do
    action :delete
  end

  link "#{new_resource.udiroot}/bin/shifterimg" do
    to '/usr/bin/shifterimg'
    action :delete
  end
end
