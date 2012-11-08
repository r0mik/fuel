class openstack::mirantis_repos {
    case $::osfamily {
      'Debian': {
        class { 'apt':
          stage => 'openstack-ci-repo'
        }->
        class { 'openstack::repo::apt':
          key => '420851BC',
          location => 'http://172.18.66.213/deb',
          key_source => 'http://172.18.66.213/gpg.pub',
          origin => '172.18.66.213',
          stage => 'openstack-ci-repo'
        }
      }
      'RedHat': {
	#$repo_baseurl='http://download.mirantis.com/epel-fuel-folsom'
        #added internal network mirror. Change if you need to use outside of mirantis
        $mirrorlist='http://172.18.67.168/centos-repo/epel-fuel-folsom/mirror.internal.list'
        class { 'openstack::repo::yum':
          repo_name  => 'openstack-epel-fuel',
          #      location   => $repo_baseurl,
          mirrorlist => $mirrorlist,
          key_source => "https://fedoraproject.org/static/0608B895.txt\n  http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-6\n http://download.mirantis.com/epel-fuel/rabbit.key",
          stage      => 'openstack-custom-repo',
          gpgcheck	=> '0'
        }
      }
      default: {
        fail("Unsupported osfamily: ${osfamily} for os ${operatingsystem}")
      }
    }
}