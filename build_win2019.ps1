packer build --only=hyperv-iso `
      --var disk_size=204800 `
      --var iso_url=d:\\iso\\en_win2019.iso `
      --var iso_checksum=a876d230944abe3bf2b5c2b40da6c4a3 `
      --var autounattend=./answer_files/2019/Autounattend.xml `
      --var hyperv_switchname=nat-switch `
      ws2019.json


packer build --only=virtualbox-iso `
      --var disk_size=204800 `
      --var iso_url=d:\\iso\\en_win2019.iso `
      --var iso_checksum=a876d230944abe3bf2b5c2b40da6c4a3 `
      --var autounattend=./answer_files/2019/Autounattend.xml
      ws2019.json