require 'facter'
Facter.add(:puppet_repo_version) do
  setcode do
    Facter::Util::Resolution.exec("/var/lib/dppd/repo/puppet/bin/config_version /var/lib/dppd/repo/puppet/")
  end
end

