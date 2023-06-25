{ config, pkgs, ... }:

{
  services.borgbackup.jobs."borgbase" = {
    paths = [
      "/home/meeri"
    ];
    exclude = [
      # very large paths
      "/home/meeri/home-media"
      "/home/meeri/media/torrents"
      "/home/meeri/documents/working-dir"
      "/home/meeri/.cache"
      "/home/meeri/.mozilla"
      "/home/meeri/tmp"
    ];
    repo = "eob45owc@eob45owc.repo.borgbase.com:repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/borgbackup/passphrase";
    };
    environment.BORG_RSH = "ssh -i /root/borgbackup/ssh_key";
    compression = "auto,lzma";
    startAt = "daily";
  };
}
