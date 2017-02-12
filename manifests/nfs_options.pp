# Aix_tidy::Nfs_options
#
# Make sure NFS filesystems are mounted correctly
# * enforce specific set of options for all mounts
# * remove all instances of localhost and $fqdn from the exports file
class aix_tidy::nfs_options($options = "rw,bg,hard,intr,nosuid,sec=sys") {
  $nfs_mounts = dig($facts, 'mountpoints').then | $mountpoints | {
    $mountpoints.filter |$index, $values| {
      $values['filesystem'] =~ "nfs"
    }.map |$index, $value| {
      $index
    }
  }

  # enforce correct options for all nfs mounts
  if $nfs_mounts {
    mount { $nfs_mounts:
      options => $options,
    }
  }

  # remove all instances of 'localhost' and $fqdn from access= attribute in
  # /etc/exports - can't do this with augeas since AIX has its own whacked
  # exports format (sigh)
}
